class Delivery < ApplicationRecord

	belongs_to :order, optional: true

	#initial not working -> default value must be manually set

	after_initialize :set_default

	state_machine :state, initial: :new do


		after_transition [:en_route_to_pickup, :issue_resolved] => :out_for_delivery do |delivery, transition|
			delivery.pickup_time = Time.now
		end

		after_transition [:out_for_delivery, :issue_resolved] => :delivered do |delivery, transition|
			delivery.dropoff_time = Time.now
			
			if !delivery.fulfillment_date.nil? && !delivery.fulfillment_time.nil?
				delivery.is_on_time = delivery.dropoff_time <= delivery.fulfillment_date && delivery.dropoff_time.to_s <= delivery.fulfillment_time.to_s
				#delivery.is_on_time = Time.now < delivery.scheduled_delivery 
			end 
			
			delivery.notify_sweetist
		end

		after_transition [:en_route_to_pickup, :issue_resolved] => :out_for_delivery do |delivery, transition|
			delivery.notify_sweetist
		end

		event :assign do
			transition [:new, :issue_resolved] => :assigned
		end

		event :begin_delivery do
			transition [:assigned, :issue_resolved] => :en_route_to_pickup
		end

		event :pickup_order do
			transition [:en_route_to_pickup, :issue_resolved] => :out_for_delivery
		end

		event :deliver do
			transition [:out_for_delivery, :issue_resolved] => :delivered
		end

		event :request_feedback do
			transition :delivered => :feedback_requested
		end

		event :receive_feedback do
			transition :feedback_requested => :complete
		end

		event :report_issue do
			transition [:new, :assigned, :en_route_to_pickup, :out_for_delivery] => :issue_reported
		end

		event :resolve_issue do
			transition :issue_reported => :issue_resolved
		end

		event :cancel do
			transition  [:new, :assigned, :en_route_to_pickup, :out_for_delivery, :issue_resolved] => :canceled
		end

		state :new
		state :assigned
		state :en_route_to_pickup
		state :out_for_delivery
		state :delivered
		state :feedback_requested
		state :complete
		state :issue_reported
		state :issue_resolved
		state :canceled

	end

	def notify_sweetist
      Sidekiq::Client.push('at' => Time.current.to_i + 2.seconds, 'class' => SweetOps, 'queue' => 'default', 'retry' => true, 'args' => [self.id])
	end

	private

	def set_default
		if !self.state.nil?
			#puts "BEFORE: "+self.state
		end
		self.state ||= :new
		if !self.state.nil?
			#puts "AFTER: "+self.state
		end
	end
end