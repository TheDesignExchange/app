require 'rails_helper'

RSpec.describe "method_case_studies/edit", :type => :view do
  before(:each) do
    @method_case_study = assign(:method_case_study, MethodCaseStudy.create!())
  end

  it "renders the edit method_case_study form" do
    render

    assert_select "form[action=?][method=?]", method_case_study_path(@method_case_study), "post" do
    end
  end
end
