require 'rails_helper'

RSpec.describe "prescriptions/new", type: :view do
  before(:each) do
    assign(:prescription, Prescription.new())
  end

  it "renders new prescription form" do
    render

    assert_select "form[action=?][method=?]", prescriptions_path, "post" do
    end
  end
end
