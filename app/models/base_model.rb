require 'faraday'

class BaseModel
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include ActiveModel::Attributes
  include ActiveModel::AttributeAssignment
  include ActiveModel::AttributeMethods
  include ActiveModel::Serialization
  extend  ActiveModel::Naming
  include ActiveModel::Serialization
  include Rails.application.routes.url_helpers

  def attributes
    super().symbolize_keys
  end

  def to_param
    self.id.to_s
  end

  def to_query
    attributes.to_query
  end

  def persisted?
    !self.id.nil?
  end
end
