require 'rails_helper'

RSpec.describe "drugs/show", type: :view do
  before(:each) do
    @drug = assign(:drug, Drug.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
