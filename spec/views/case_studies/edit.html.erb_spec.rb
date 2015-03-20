require 'rails_helper'

RSpec.describe "case_studies/edit", :type => :view do
  before(:each) do
    @case_study = assign(:case_study, CaseStudy.create!())
  end

  it "renders the edit case_study form" do
    render

    assert_select "form[action=?][method=?]", case_study_path(@case_study), "post" do
    end
  end
end
