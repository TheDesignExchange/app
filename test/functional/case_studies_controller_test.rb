require 'test_helper'

class CaseStudiesControllerTest < FunctionalTestCase
  setup do
    @case_study = case_studies(:iWitness)
    @user = users(:jack)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success  
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get related_methods" do
    get :related_methods, id: @case_study
    assert_response :success
  end 

  test "should create case_studies" do
    assert_difference 'CaseStudy.count', 1 do
      post :create, case_studies: {
        name: @case_study.name + " 2",
      }
    end
  end

  test "should show case_studies" do
    get  :show, id: @case_study
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @case_study
    assert_response :success
  end

  test "should update case_studies" do
    put :update, id: @case_study, case_studies: { 
      name: @case_study.name 
    }
    assert_redirected_to case_study_path(assigns(:case_study))
  end

  # test "should destroy case_studies" do
  #   assert_difference('DesignMethod.count', -1) do
  #     delete :destroy, id: @case_study
  #   end

  #   assert_redirected_to case_studies_path
  # end
end