require 'rails_helper'

RSpec.describe "advanced_searches/edit", :type => :view do
  before(:each) do
    @advanced_search = assign(:advanced_search, AdvancedSearch.create!())
  end

  it "renders the edit advanced_search form" do
    render

    assert_select "form[action=?][method=?]", advanced_search_path(@advanced_search), "post" do
    end
  end
end
