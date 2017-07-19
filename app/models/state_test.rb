class StateTest < ApplicationRecord

	after_initialize :set_default

	state_machine :state, initial: :first do

		event :next do
			transition [:first] => :second
			transition [:second] => :third
		end

		state :first
		state :second
		state :third
	end

	private

	def set_default
		self.state ||= :first
	end
end
