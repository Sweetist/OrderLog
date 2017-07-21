module Syncable
  extend ActiveSupport::Concern

  def post_data(url, content_type=nil, payload = {})
      # if Rails.env == "production" || Rails.env == "staging"
      uri = URI.parse(url)

        # DEBUG
        # port = 3000
        # http = Net::HTTP.new(uri.host, port)
        # END DEBUG
        

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        req = Net::HTTP::Post.new(uri.to_s)
        req.body = payload#.to_json
        req.content_type = content_type || 'application/json'
        http.request(req)
      # else
      #   { code: "200", body: "NOTIFICATION WARNING: POST ping is allowed only in Production. - #{url} with #{payload.to_json}" }
      # end
    end
end