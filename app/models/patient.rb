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
end
