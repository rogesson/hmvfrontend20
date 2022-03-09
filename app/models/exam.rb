class Exam < BaseModel
  attribute :id, :integer
  attribute :result, :string
  attribute :patient, Patient
  attribute :type, ExamType

  validates_presence_of :name

  ENDPOINT = '/examentry'.freeze

  def self.find(id)
    response = super("#{ENDPOINT}/id/#{id}")

    return unless response

    self.new(
      id: response['examEntryId'],
      result: response['examResult'],
      date: response['examDateTime'],
      patient: response['patient'],
      type: response['examType'],
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

    response = RequestService::put("#{ENDPOINT}/" + id.to_s, data)
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
