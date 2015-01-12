require 'rails_helper'

RSpec.describe "FeedbacksSubmissions", :type => :request do
  describe "GET /feedbacks_submissions" do
    it "works! (now write some real specs)" do
      get feedbacks_submissions_path
      expect(response.status).to be(200)
    end
  end
end
