require 'spec_helper'

describe CollectionController do

  describe "GET 'casestudies'" do
    it "returns http success" do
      get 'casestudies'
      response.should be_success
    end
  end

end
