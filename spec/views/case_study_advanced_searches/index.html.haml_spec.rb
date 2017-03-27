require 'rails_helper'

RSpec.describe "case_study_advanced_searches/index", :type => :view do
  before(:each) do
    assign(:case_study_advanced_searches, [
      CaseStudyAdvancedSearch.create!(),
      CaseStudyAdvancedSearch.create!()
    ])
  end

  it "renders a list of case_study_advanced_searches" do
    render
  end
end
