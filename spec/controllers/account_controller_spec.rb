require 'rails_helper'

RSpec.describe AccountController, :type => :controller do

  describe "GET 'profile_user'" do
    it "returns http success" do
      get 'profile_user'
      expect(response).to be_success
    end
  end

end
