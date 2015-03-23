require 'rails_helper'

RSpec.describe "MethodCaseStudies", :type => :request do
  describe "GET /method_case_studies" do
    it "works! (now write some real specs)" do
      get method_case_studies_path
      expect(response.status).to be(200)
    end
  end
end
