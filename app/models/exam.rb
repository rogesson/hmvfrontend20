class Exam < BaseModel
  attribute :id, :integer
  attribute :result, :string
  attribute :date, :string

  #attribute :patient, :patient
  #attribute :type, ExamType

  validates_presence_of :result

  ENDPOINT = '/examentry'.freeze

  attr_accessor :patient, :exam_type

  def full_date
    # [TODO] fix hour and minutes
    Date.parse(date).strftime('%d/%m/%Y %H:%M')
  end

  def self.find(id)
    response = super("#{ENDPOINT}/id/#{id}")

    return unless response

    {"examEntryId":8,
     "examResult":"12%",
     "examDateTime":"2022-03-13T20:19:34",
     "patient":
     {"userId":2,
      "name":"Fulano",
      "email":"teste@gmail.com",
      "cpf":"123456789",
      "password":"corinthians123"
    },
    "examType":
    {
      "examTypeId":4,
      "examName":"Cardiológico"
    }}

    patient_attr = {
      id: response['patient']['userId'],
      name: response['patient']['name'],
      email: response['patient']['email'],
      cpf: response['patient']['cpf'],
      password: response['patient']['password']
    }

    self.new(
      id: response['examEntryId'],
      result: response['examResult'],
      date: response['examDateTime'],
      patient: Patient.new(patient_attr),
      exam_type: response['examType']
    )
  end

  def update(new_attributes)
    new_attributes.each do |k, v|
      self.send("#{k}=", v)
    end

    response = RequestService::put("#{ENDPOINT}/" + id.to_s, data)
  end

  def self.all
    response = RequestService::get(ENDPOINT)
    return [] unless response

    response["content"].map do |resource|
      patient_attr = {
        id: resource['patient']['userId'],
        name: resource['patient']['name'],
        email: resource['patient']['email'],
        cpf: resource['patient']['cpf'],
        password: resource['patient']['password']
      }

      Exam.new(
        id: resource['examEntryId'],
        date: resource['examDateTime'],
        patient: Patient.new(patient_attr)
      )
    end
  end

  def save
    raise "Invalid Record! #{self.attributes}" unless valid?

    data = {
      "examResult" => result,
      "examDateTime" => Time.now.strftime('%FT%T'),
      "examTypeId" => 4,
      "patientId" => 2
    }

    response = RequestService.post(ENDPOINT, data)
    self.id = response["examEntryId"]
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

  def to_request
    attr = self.attributes
    attr[:patient] = self.patient.attributes
  end
end
