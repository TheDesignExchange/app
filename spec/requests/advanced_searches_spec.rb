require 'rails_helper'

RSpec.describe "AdvancedSearches", :type => :request do
  describe "GET /advanced_searches" do
    it "works! (now write some real specs)" do
      get advanced_searches_path
      expect(response.status).to be(200)
    end
  end
end
