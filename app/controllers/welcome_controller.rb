require 'net/http'

class WelcomeController < ApplicationController
  def index
    result = Net::HTTP.get(
      URI.parse('http://172.22.0.1:8080/api/v1/drug')
    )
    puts result
  end
end
