require 'rails_helper'

RSpec.describe "case_study_advanced_searches/show", :type => :view do
  before(:each) do
    @case_study_advanced_search = assign(:case_study_advanced_search, CaseStudyAdvancedSearch.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
