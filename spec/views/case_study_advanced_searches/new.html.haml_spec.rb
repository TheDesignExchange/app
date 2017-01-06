require 'rails_helper'

RSpec.describe "case_study_advanced_searches/new", :type => :view do
  before(:each) do
    assign(:case_study_advanced_search, CaseStudyAdvancedSearch.new())
  end

  it "renders new case_study_advanced_search form" do
    render

    assert_select "form[action=?][method=?]", case_study_advanced_searches_path, "post" do
    end
  end
end
