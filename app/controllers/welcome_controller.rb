require 'faraday'

class WelcomeController < ApplicationController
  def index
    response = Faraday.get('http://172.22.0.1:8080/api/v1/drug')

    puts response.body
  end
end
