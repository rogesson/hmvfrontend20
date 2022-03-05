require 'rails_helper'

RSpec.describe "drugs/edit", type: :view do
  before(:each) do
    @drug = assign(:drug, Drug.create!())
  end

  it "renders the edit drug form" do
    render

    assert_select "form[action=?][method=?]", drug_path(@drug), "post" do
    end
  end
end
