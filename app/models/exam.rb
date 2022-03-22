class Exam < BaseModel
  attribute :id, :integer
  attribute :result, :string
  attribute :date, :string

  #attribute :patient, :patient
  #attribute :type, ExamType

  #validates_presence_of :result

  ENDPOINT = '/examentry'.freeze

  attr_accessor :patient, :exam_type

  def full_date
    # [TODO] fix hour and minutes
    Date.parse(date).strftime('%d/%m/%Y %H:%M')
  end

  def self.find(id)
    response = super("#{ENDPOINT}/id/#{id}")

    return unless response

    patient_attr = {
      id: response['patient']['userId'],
      name: response['patient']['name'],
      email: response['patient']['email'],
      cpf: response['patient']['cpf'],
      password: response['patient']['password']
    }

    exam_type_attr = {
      "id" => response['examType']['examTypeId'],
      "name" => response['examType']['examName']
    }

    self.new(
      id: response['examEntryId'],
      result: response['examResult'],
      date: response['examDateTime'],
      patient: Patient.new(patient_attr),
      exam_type: ExamType.new(exam_type_attr)
    )
  end

  def update(new_attributes)
    new_attributes.each do |k, v|
      self.send("#{k}=", v)
    end

    self.patient = Patient.new(new_attributes[:patient])
    self.exam_type = ExamType.new(new_attributes[:exam_type])

    data = {
      "examDateTime": "2022-03-22T22:19:48.939Z",
      "examResult": result,
      "examTypeId": exam_type.id,
      "patientId": patient.id,
    }

    RequestService::put("#{ENDPOINT}/" + id.to_s, data)
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
      "examTypeId" => exam_type.id,
      "patientId" => patient.id
    }

    response = RequestService.post(ENDPOINT, data)
    self.id = response["examEntryId"]
    self.date = data["examDateTime"]
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
