require 'net/http'
require 'uri'
require 'json'

class DeliveryNotifier

  def initialize()
  end

  def post_change( address, delivery_number, event )
    url = URI.parse(address) 
    
    header = {'Content-Type': 'text/json'}
    delivery = Delivery.find_by(delivery_number: delivery_number)

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, header)
    
    request.body = user.to_json
    
    response = http.request(request)
  end
end