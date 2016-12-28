require 'rails_helper'

RSpec.describe "advanced_searches/new", :type => :view do
  before(:each) do
    assign(:advanced_search, AdvancedSearch.new())
  end

  it "renders new advanced_search form" do
    render

    assert_select "form[action=?][method=?]", advanced_searches_path, "post" do
    end
  end
end
