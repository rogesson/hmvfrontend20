require 'rails_helper'

RSpec.describe "prescriptions/show", type: :view do
  before(:each) do
    @prescription = assign(:prescription, Prescription.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
