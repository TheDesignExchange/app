require 'test_helper'

class MethodCategoriesControllerTest < FunctionalTestCase
  setup do 
  	@method_category = method_categories(:one)
  end 

  test "should show method_category" do
    get :show, id: @method_category
    assert_response :success
  end

end
