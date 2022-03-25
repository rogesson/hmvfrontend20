class ExamType < BaseModel
  attribute :id, :integer
  attribute :name, :string

  ENDPOINT = '/examtype'.freeze
  CUSTOM_ATTRIBUTES = {
    id: 'examTypeId',
    name: 'examName'
  }

  def self.all
    response = RequestService::get(ENDPOINT)
    return [] unless response

    #{"content":[{"examTypeId":4,"examName":"Cardiológico"}]
    response["content"].map do |resource|
      attr = {
        id: resource['examTypeId'],
        name: resource['examName'],
      }

      ExamType.new(attr)
    end
  end
end
