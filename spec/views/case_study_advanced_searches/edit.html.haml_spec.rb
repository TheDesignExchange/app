require 'rails_helper'

RSpec.describe "case_study_advanced_searches/edit", :type => :view do
  before(:each) do
    @case_study_advanced_search = assign(:case_study_advanced_search, CaseStudyAdvancedSearch.create!())
  end

  it "renders the edit case_study_advanced_search form" do
    render

    assert_select "form[action=?][method=?]", case_study_advanced_search_path(@case_study_advanced_search), "post" do
    end
  end
end
