require 'rails_helper'

RSpec.describe "prescriptions/edit", type: :view do
  before(:each) do
    @prescription = assign(:prescription, Prescription.create!())
  end

  it "renders the edit prescription form" do
    render

    assert_select "form[action=?][method=?]", prescription_path(@prescription), "post" do
    end
  end
end
