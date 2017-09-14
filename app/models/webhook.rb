class Webhook < ApplicationRecord
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
