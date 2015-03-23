require 'rails_helper'

RSpec.describe "method_case_studies/show", :type => :view do
  before(:each) do
    @method_case_study = assign(:method_case_study, MethodCaseStudy.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
