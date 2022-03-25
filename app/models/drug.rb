class Drug < BaseModel
  attribute :id, :integer
  attribute :name, :string

  validates_presence_of :name

  ENDPOINT = '/drug'.freeze

  CUSTOM_ATTRIBUTES = {
    id: 'drugId',
    name: 'drugName'
  }
end
