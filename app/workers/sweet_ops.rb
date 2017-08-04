class SweetOps
  include Sidekiq::Worker
  include Syncable

  def perform(syncable_id)
    url = "https://requestb.in/zaud27za"
    #url = "#{ENV['SWEET_INTEGRATION_URL']}/api/integrations/#{sweet_integration_num}/execute.json?"
    delivery = Delivery.find_by_id(syncable_id)
    json_payload = delivery.as_json
    puts "sending request"
    self.post_data(url, 'application/x-www-form-urlencoded', json_payload)

  rescue ActiveRecord::RecordNotFound
    puts "Error"
    true # moving on if error found
  end
end