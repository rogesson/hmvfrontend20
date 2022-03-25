class Patient < BaseModel
  attribute :id, :integer
  attribute :name, :string
  attribute :email, :string
  attribute :cpf, :string
  attribute :password, :string

  ENDPOINT = '/userdetails'.freeze
  CUSTOM_ATTRIBUTES = {
    id: 'userId',
    name: 'name',
    email: 'email',
    cpf: 'cpf',
    password: 'password'
  }

  def self.all
    response = RequestService::get(ENDPOINT)
    return [] unless response

    response["content"].map do |resource|
      patient_attr = {
        id: resource['userId'],
        name: resource['name'],
        email: resource['email'],
        cpf: resource['cpf'],
        password: resource['password']
      }

      Patient.new(patient_attr)
    end
  end
end
