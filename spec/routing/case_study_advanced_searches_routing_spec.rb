require "rails_helper"

RSpec.describe CaseStudyAdvancedSearchesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/case_study_advanced_searches").to route_to("case_study_advanced_searches#index")
    end

    it "routes to #new" do
      expect(:get => "/case_study_advanced_searches/new").to route_to("case_study_advanced_searches#new")
    end

    it "routes to #show" do
      expect(:get => "/case_study_advanced_searches/1").to route_to("case_study_advanced_searches#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/case_study_advanced_searches/1/edit").to route_to("case_study_advanced_searches#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/case_study_advanced_searches").to route_to("case_study_advanced_searches#create")
    end

    it "routes to #update" do
      expect(:put => "/case_study_advanced_searches/1").to route_to("case_study_advanced_searches#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/case_study_advanced_searches/1").to route_to("case_study_advanced_searches#destroy", :id => "1")
    end

  end
end
