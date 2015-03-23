require 'rails_helper'

RSpec.describe "method_case_studies/index", :type => :view do
  before(:each) do
    assign(:method_case_studies, [
      MethodCaseStudy.create!(),
      MethodCaseStudy.create!()
    ])
  end

  it "renders a list of method_case_studies" do
    render
  end
end
