require 'rails_helper'

RSpec.describe "advanced_searches/index", :type => :view do
  before(:each) do
    assign(:advanced_searches, [
      AdvancedSearch.create!(),
      AdvancedSearch.create!()
    ])
  end

  it "renders a list of advanced_searches" do
    render
  end
end
