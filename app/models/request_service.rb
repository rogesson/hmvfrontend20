require 'faraday'

module RequestService
  API_ENDPOINT = 'http://172.22.0.1:8080/api/v1'

  def self.get(uri='')
    response = Faraday.get(
      API_ENDPOINT + uri,
      "Content-Type" => "application/json"
    )

    puts "REQUEST>>>>>>"
    puts response.status
    puts response.body
    puts "REQUEST<<<<<<"

    parse_response(response)
  end

  def self.put(uri, data)
    response = Faraday.put(
      API_ENDPOINT + uri,
      data.to_json,
      "Content-Type" => "application/json"
    )

    parse_response(response)
  end

  def self.post(uri, data)
    response = Faraday.post(
      API_ENDPOINT + uri,
      data.to_json,
      "Content-Type" => "application/json"
    )

    parse_response(response)
  end

  def self.delete(uri)
    response = Faraday.delete(
      API_ENDPOINT + uri,
      {},
      "Content-Type" => "application/json"
    )

    response.body
  end

  private

    def self.parse_response(response)
      return if response.status == 500

      JSON.parse(response.body)
    end
end
