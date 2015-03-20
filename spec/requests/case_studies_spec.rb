require 'rails_helper'

RSpec.describe "CaseStudies", :type => :request do
  describe "GET /case_studies" do
    it "works! (now write some real specs)" do
      get case_studies_path
      expect(response.status).to be(200)
    end
  end
end
