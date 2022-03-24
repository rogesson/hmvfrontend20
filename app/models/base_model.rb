class BaseModel
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations
  include ActiveModel::Attributes
  include ActiveModel::AttributeAssignment
  include ActiveModel::AttributeMethods
  include ActiveModel::Serialization
  extend ActiveModel::Naming

  def initialize(response = {})
    attr = new_attributes(response)
    super(attr)
  end

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

  def save
    return false unless valid?

    data = to_request(self.attributes)

    response = RequestService.post(self::class::ENDPOINT, data)

    attr = new_attributes(response)
    assign_attributes(attr)
  end

  def self.find(id)
    response = RequestService::get("#{self::ENDPOINT}/id/#{id}")
    return unless response

    self.new(response)
  end

  def update(attr)
    data = to_request(attr)

    debugger
    response = RequestService::put("#{self::class::ENDPOINT}/" + id.to_s, data)
    raise "Update error" unless response

    assign_attributes(attr)
  end

  def destroy
    response = RequestService.delete("#{self::class::ENDPOINT}/#{id}")
    response[:status] == 200
  end

  def self.last
    self.class.all.last
  end

  def to_request(attr)
    data = {}
    attr.each do |key, val|
      data[self::class::CUSTOM_ATTRIBUTES.fetch(key.to_sym)] = val
    end

    data
  end

  def self.all
    response = RequestService::get(self::ENDPOINT)
    return [] unless response

    response["content"].map do |drug|
      self.new(drug)
    end
  end

  private

  def new_attributes(response)
    final_attr = {}

    self::class::CUSTOM_ATTRIBUTES.map do |k, v|
      final_attr[k] = response[v]
    end

    final_attr = if final_attr.values.compact.empty?
                   response.to_h.deep_symbolize_keys
                 else
                   final_attr
                 end
    final_attr
  end
end
