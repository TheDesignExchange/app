require 'test_helper'

class UsersControllerTest < FunctionalTestCase
  setup do
    @user = users(:jack)
    sign_in @user
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  # test "should create user" do
	 #  assert_difference 'User.count', 1 do
	 #    post :create, user: {
	 #      email: @user.email,
	 #      encrypted_password: @user.encrypted_password,
	 #      first_name: @user.first_name,
	 #      last_name: @user.last_name,
  #       }
  #     end
  #   assert_redirected_to user_path(assigns(:user))
  # end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  # test "should update user" do
  #   put :update, id: @user, user: { 
  #      email: @user.email,
  #      encrypted_password: @user.encrypted_password,
  #      first_name: @user.first_name,
  #      last_name: @user.last_name,
  #   }
  #   assert_redirected_to user_path(assigns(:user))
  # end

end
