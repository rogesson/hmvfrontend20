class Exam < BaseModel
  attribute :id, :integer
  attribute :result, :string
  attribute :date, :string

  validates_presence_of :result, :date

  ENDPOINT = '/examentry'.freeze

  CUSTOM_ATTRIBUTES = {
    id: 'examEntryId',
    result: 'examResult',
    date: 'examDateTime',
    patient: {
      'patient' => {
        id: 'patientId',
        name: 'name',
        email: 'email',
        cpf: 'cpf',
        password: 'password'
      }
    },
    exam_type: {
      'examType' => {
        id: 'examTypeId',
        name: 'examName'
      }
    }
  }

  attr_accessor :patient, :exam_type

  def full_date
    Date.parse(date).strftime('%d/%m/%Y')
  end

  def date_for_select
    return Date.today.strftime('%Y-%m-%d') unless date

    Date.parse(date).strftime('%Y-%m-%d')
  end

  def attr_to_request(data)
    data['examDateTime'] = Date.parse(date)
                               .strftime("%Y-%m-%dT00:00:00.257Z")

    data
  end
end
