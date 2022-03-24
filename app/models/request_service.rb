require 'faraday'

module RequestService
  API_ENDPOINT = 'http://172.22.0.1:8080/api/v1'

  def self.get(uri = '')
    response = Faraday.get(
      API_ENDPOINT + uri,
      "Content-Type" => "application/json"
    )

    puts "[GET] REQUEST>>>>>>"
    puts uri
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

    puts "[PUT] REQUEST>>>>>>"
    puts uri
    puts data
    puts response.status
    puts response.body
    puts "REQUEST<<<<<<"

    parse_response(response)
  end

  def self.post(uri, data)
    response = Faraday.post(
      API_ENDPOINT + uri,
      data.to_json,
      "Content-Type" => "application/json"
    )

    puts "[POST] REQUEST>>>>>>"
    puts uri
    puts data
    puts response.status
    puts response.body
    puts "REQUEST<<<<<<"

    parse_response(response)
  end

  def self.delete(uri)
    response = Faraday.delete(
      API_ENDPOINT + uri,
      {},
      "Content-Type" => "application/json"
    )

    puts "[DELETE] REQUEST>>>>>>"
    puts uri
    puts {}
    puts response.status
    puts response.body
    puts "REQUEST<<<<<<"

    { body: response.body, status: response.status }
  end

  private

  def self.parse_response(response)
    if [404].include?(response.status)
      return nil # [TODO] return
    end

    if ![200, 201, 203, 302].include?(response.status)
      self.raise_http_error(response.status)
    end

    begin
      JSON.parse(response.body)
    rescue => e
      puts e

      self.raise_http_error(response.status)
    end
  end

  def self.raise_http_error(status)
    raise "Invalid Request: StatusCode: #{status}"
  end
end
