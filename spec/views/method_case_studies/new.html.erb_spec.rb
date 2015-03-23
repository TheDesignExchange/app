require 'rails_helper'

RSpec.describe "method_case_studies/new", :type => :view do
  before(:each) do
    assign(:method_case_study, MethodCaseStudy.new())
  end

  it "renders new method_case_study form" do
    render

    assert_select "form[action=?][method=?]", method_case_studies_path, "post" do
    end
  end
end
