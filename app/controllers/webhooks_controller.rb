class WebhooksController < ApplicationController
  def index
    @responses = Response.all
    @parsed =  []
    @api_responses = []

    @responses.each do |response|
      @parsed << JSON.parse(response.data)
    end

  @parsed.each do |api_call|
    if api_call["type"] == "access_revoked" || api_call["type"] == "access_granted" || api_call["type"] == "access_modified"
      @api_responses << JSON.parse(get_resource(ENV['TINYPASS_API_TOKEN'], ENV['TINYPASS_AID'], api_call["uid"], api_call["rid"]))
    end
  end

  render json: @api_responses
 end


 def get_resource(api_token, aid, uid, rid)
   url = 'https://sandbox.tinypass.com/api/v3/publisher/user/access/check'
   data = {
     "api_token" => api_token,
     "aid" => aid,
     "rid" => rid,
     "uid" => uid
   }
   client = HTTPClient.new.get(url, data)
   return client.body
 end
end
