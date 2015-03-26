require 'test_helper'

class MethodCategoriesControllerTest < ActionController::TestCase
  setup do 
  	@method_category = method_categories(:one)
  end 

  test "should show design_method" do
    get :show, id: @method_category
    assert_response :success
  end

end
