require 'rails_helper'

RSpec.describe "advanced_searches/show", :type => :view do
  before(:each) do
    @advanced_search = assign(:advanced_search, AdvancedSearch.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
