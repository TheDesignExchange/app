require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  setup do
  	@tag = tags(:one)
  	@user = users(:one)
  	sign_in @user
  end 

  test "should get create tag" do
  	get :create
  	assert_response :success 
  end

	# test "should get tagify" do
 #  	get :tagify 
 #  	assert_response :success 
	# end 
end
