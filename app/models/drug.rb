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

  validates_presence_of :name

  def self.find(id)
    response = self.request_get('/drug/id/' + id)
    if response.status == 302
      drug = JSON.parse(response.body)
      self.new(
        id: drug['drugId'],
        name: drug['drugName']
      )
    else 
      nil
    end
  end

  def update(new_attributes)
    puts "new_attributes"
    puts new_attributes
    new_attributes.each do |k, v|
      self.send("#{k}=", v)
    end

    response = request_put('/drug/' + id.to_s, self)
  end

  def self.all
    response = self.request_get('/drug')
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
    return false unless valid?

    body = request_post('/drug', self)
    self.id = body["drugId"]
    self
  end

  def destroy
    response = request_delete("/drug/#{id}")
    puts response
  end

  def attributes
    super().symbolize_keys
  end

  def to_param
    self.id.to_s
  end

  def to_query
    attributes.to_query
  end

  def persisted?
    !self.id.nil?
  end

  private

    def self.request_get(uri='')
      response = Faraday.get(
        API_ENDPOINT + uri,
        "Content-Type" => "application/json"
      )

      puts "REQUEST>>>>>>"
      puts response.status
      puts response.body
      puts "REQUEST<<<<<<"


      response
    end

    def request_post(uri, data)
      params = { 
        "drugName" => data.name
      }

      response = Faraday.post(
        API_ENDPOINT + uri,
        params.to_json,
        "Content-Type" => "application/json"
      )

      response.body
    end

    def request_delete(uri)
      response = Faraday.delete(
        API_ENDPOINT + uri,
        {},
        "Content-Type" => "application/json"
      )

      response.body
    end
end
