class Patient < BaseModel
  attribute :id, :integer
  attribute :name, :string
  attribute :email, :string
  attribute :cpf, :string
  attribute :password, :string
end
