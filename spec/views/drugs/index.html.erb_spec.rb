require 'rails_helper'

RSpec.describe "drugs/index", type: :view do
  before(:each) do
    assign(:drugs, [
      Drug.create!(),
      Drug.create!()
    ])
  end

  it "renders a list of drugs" do
    render
  end
end
