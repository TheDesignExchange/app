require 'rails_helper'

RSpec.describe "case_studies/new", :type => :view do
  before(:each) do
    assign(:case_study, CaseStudy.new())
  end

  it "renders new case_study form" do
    render

    assert_select "form[action=?][method=?]", case_studies_path, "post" do
    end
  end
end
