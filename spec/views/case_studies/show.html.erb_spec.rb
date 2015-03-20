require 'rails_helper'

RSpec.describe "case_studies/show", :type => :view do
  before(:each) do
    @case_study = assign(:case_study, CaseStudy.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
