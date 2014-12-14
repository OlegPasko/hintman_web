class Push
  require 'net/http'

  def initialize(type)
    @url = 'https://api.parse.com/1/'
    @type = type
  end

  def get_uri
    URI::parse(@url + @type)
  end

  def subscribe(device_type, device_token)
    data = {deviceType: device_type, deviceToken: device_token, channels: ['']}
    response = http_post(data)
    if response.code == '201'
      response = 'Ok.'
    else
      response = response.body
    end

    response
  end

  def send(device_token, message)
    if @type == 'push'
      data = {where: {deviceToken: device_token}, data: {alert: message}}
      response = http_post(data)

      if response.code == '201' || response.code == '200'
        response = 'Ok.'
      else
        response = response.body
      end

      response
    else
      'Change type to "push" before do that.'
    end
  end

  private

  def http_post(data)
    uri = URI::parse(@url + @type)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path, {'Content-Type' =>'application/json'})
    request['X-Parse-Application-Id'] = PARSE_APPLICATION_ID
    request['X-Parse-REST-API-Key'] = PARSE_REST_API_KEY
    request.body = data.to_json

    http.request(request)
  end
end