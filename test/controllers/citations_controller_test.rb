require 'test_helper'

class CitationsControllerTest < FunctionalTestCase
  setup do 
  	@citation = citations(:MITstudy)
  end

  test "should show citation" do
    get :show, id: @citation 
    assert_response :success
  end
end
