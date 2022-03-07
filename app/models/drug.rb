class Drug < BaseModel
  attribute :id, :integer
  attribute :name, :string

  validates_presence_of :name

  def self.find(id)
    response = RequestService::get("/drug/id/#{id}")
    if response.status == 302
      drug = JSON.parse(response.body)
      self.new(
        id: drug['drugId'],
        name: drug['drugName']
      )
    else 
      nil
    end
  end

  def update(new_attributes)
    new_attributes.each do |k, v|
      self.send("#{k}=", v)
    end

    data = { 
      "drugId"   => id,
      "drugName" => name
    }

    response = RequestService::put('/drug/' + id.to_s, data)
  end

  def self.all
    response = RequestService::get('/drug')

    if response.status == 302
      @drugs = JSON.parse(response.body)["content"].map do |drug|
        Drug.new(
          id: drug['drugId'],
          name: drug['drugName']
        )
      end
    else 
      puts response.inspect
      []
    end
  end

  def save
    return false unless valid?

    data = { 
      "drugName" => name
    }

    body = RequestService.post('/drug', data)
    self.id = JSON.parse(body)["drugId"]
    self
  end

  def destroy
    response = RequestService.delete("/drug/#{id}")
    puts response
  end

  def self.last
    Drug.all.last
  end
end
