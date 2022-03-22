class Drug < BaseModel
  attribute :id, :integer
  attribute :name, :string

  validates_presence_of :name

  ENDPOINT = '/drug'.freeze

  def self.find(id)
    response = super("#{ENDPOINT}/id/#{id}")

    return unless response

    self.new(
      id: response['drugId'],
      name: response['drugName']
    )
  end

  def update(new_attributes)
    new_attributes.each do |k, v|
      self.send("#{k}=", v)
    end

    data = { 
      "drugId"   => id,
      "drugName" => name
    }

    RequestService::put("#{ENDPOINT}/" + id.to_s, data)
  end

  def self.all
    response = RequestService::get(ENDPOINT)
    return [] unless response

    response["content"].map do |drug|
      Drug.new(
        id: drug['drugId'],
        name: drug['drugName']
      )
    end
  end

  def save
    return false unless valid?

    data = { 
      "drugName" => name
    }

    response = RequestService.post(ENDPOINT, data)
    self.id = response["drugId"]
    self
  end

  def destroy
    response = RequestService.delete("#{ENDPOINT}/#{id}")
    puts response
    true
  end

  def self.last
    self.class.all.last
  end
end
