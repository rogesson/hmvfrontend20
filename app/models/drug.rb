require 'faraday'

class Drug
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include ActiveModel::Attributes
  include ActiveModel::AttributeAssignment
  include ActiveModel::AttributeMethods
  include ActiveModel::Serialization
  extend ActiveModel::Naming
  include ActiveModel::Serialization
  include Rails.application.routes.url_helpers

  API_ENDPOINT = 'http://172.22.0.1:8080/api/v1'

  attribute :id, :integer
  attribute :name, :string

  def self.find(id)
    self
  end

  def self.all
    response = self.get
    if response.status == 302
      @drugs = JSON.parse(response.body)["content"].map do |drug|
        Drug.new(
          id: drug['drugId'],
          name: drug['drugName']
        )
      end
    else 
      puts response.inspect
      []
    end
  end

  def save
    body = post(self.attributes)
    self.id = body["drugId"]
    self
  end

  def attributes
    super().symbolize_keys
  end

  def to_param
    self.id.to_s
  end

  private

    def self.get
      response = Faraday.get(
        API_ENDPOINT + '/drug',
        "Content-Type" => "application/json"
      )

      response
    end

    def post(data)
      params = { 
        "drugName" => data.name
      }

      url = API_ENDPOINT + '/drug'

      response = Faraday.post(
        API_ENDPOINT + '/drug',
        params.to_json,
        "Content-Type" => "application/json"
      )

      response.body
    end
end
