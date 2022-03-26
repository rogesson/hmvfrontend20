require 'rails_helper'

RSpec.describe "prescriptions/index", type: :view do
  before(:each) do
    assign(:prescriptions, [
      Prescription.create!(),
      Prescription.create!()
    ])
  end

  it "renders a list of prescriptions" do
    render
  end
end
