require 'rails_helper'

RSpec.describe "case_studies/index", :type => :view do
  before(:each) do
    assign(:case_studies, [
      CaseStudy.create!(),
      CaseStudy.create!()
    ])
  end

  it "renders a list of case_studies" do
    render
  end
end
