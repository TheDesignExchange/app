require "rails_helper"

RSpec.describe MethodCaseStudiesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/method_case_studies").to route_to("method_case_studies#index")
    end

    it "routes to #new" do
      expect(:get => "/method_case_studies/new").to route_to("method_case_studies#new")
    end

    it "routes to #show" do
      expect(:get => "/method_case_studies/1").to route_to("method_case_studies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/method_case_studies/1/edit").to route_to("method_case_studies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/method_case_studies").to route_to("method_case_studies#create")
    end

    it "routes to #update" do
      expect(:put => "/method_case_studies/1").to route_to("method_case_studies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/method_case_studies/1").to route_to("method_case_studies#destroy", :id => "1")
    end

  end
end
