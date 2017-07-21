class DeliveryNotificationJob < ApplicationJob
  queue_as :default

  def perform(syncable_id, syncable_class, sweet_integration_num)
  	url = "sweetist_spree_location"
    #url = "#{ENV['SWEET_INTEGRATION_URL']}/api/integrations/#{sweet_integration_num}/execute.json?"
    if syncable_class == 'Delivery'
      order = Delivery.find_by(id: syncable_id)
      #url << "name=order"
      json_payload = order.as_json
    end
    puts "Sending Request"+json_payload.to_s
    self.post_data(url, 'application/x-www-form-urlencoded', json_payload)

  rescue ActiveRecord::RecordNotFound
    puts "Error"
    true # moving on if error found
  end

end
