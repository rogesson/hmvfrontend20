class Prescription < BaseModel
  ENDPOINT = '/prescription'.freeze

  attribute :id, :integer
  attribute :description, :string
  attribute :date, :string

  CUSTOM_ATTRIBUTES = {
    id: 'prescriptionId',
    description: 'prescription',
    date: 'prescriptionDate',
    patient: {
      'patient' => {
        id: 'patientId',
        name: 'name',
        email: 'email',
        cpf: 'cpf',
        password: 'password'
      }
    },
    drug: {
      'drug' => {
        id: 'drugId',
        name: 'drugName'
      }
    }
  }

  attr_accessor :patient, :drug

  def full_date
    Date.parse(date).strftime('%d/%m/%Y')
  end

  def date_for_select
    return unless date
    Date.parse(date).strftime('%Y-%m-%d')
  end

  def attr_to_request(data)
    data['prescriptionTime'] = Date.today.strftime("%Y-%m-%dT00:00:00.257Z")

    data
  end
end
