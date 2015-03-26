require 'test_helper'

class MethodCaseStudiesControllerTest < ActionController::TestCase
  setup do 
  	@method_case_study = method_case_studies(:one)
  	@user = users(:one)
  	sign_in @user 
  end

  test "should create method_case_study" do
    assert_difference 'MethodCaseStudy.count', 1 do
      post :create, method_case_study: {
        id: @method_case_study.id
      }
    end 
    assert_redirected_to method_case_study_path(assigns(:method_case_study))
  end

  # test "should destroy method_case_study" do 
  #   assert_difference('MethodCaseStudy.count', -1) do
  #     delete :destroy, id: @method_case_study
  #   end 
  #   assert_redirected_to method_case_study_path(assigns(:method_case_study))
  # end

end 




  