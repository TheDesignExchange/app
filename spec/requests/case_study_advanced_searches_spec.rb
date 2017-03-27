require 'rails_helper'

RSpec.describe "CaseStudyAdvancedSearches", :type => :request do
  describe "GET /case_study_advanced_searches" do
    it "works! (now write some real specs)" do
      get case_study_advanced_searches_path
      expect(response.status).to be(200)
    end
  end
end
