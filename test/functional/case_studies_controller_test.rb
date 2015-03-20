require 'test_helper'

class CaseStudiesControllerTest < ActionController::TestCase
  setup do
    @case_studies = case_studies(:one)
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
    get :related_methods
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

#t.integer :development_cycle, :design_phase, :project_domain, :customer_type, :user_age, :privacy_level, :social_setting
#t.text :description
  test "should create case_studies" do
    assert_difference('CaseStudy.count') do
      post :create, case_studies: { development_cycle: @case_studies.development_cycle, design_phase: @case_studies.design_phase, project_domain: @case_studies.project_domain, customer_type: @case_studies.customer_type, user_age: @case_studies.user_age, privacy_level: @case_studies.privacy_level, social_setting: @case_studies.social_setting, description: @case_studies.description }
    end
  end

  test "should show case_studies" do
    get :show, id: @case_studies
    assert_response :success
  end 

  test "should update case_studies" do
    put :update, id: @case_studies, case_studies: { development_cycle: @case_studies.development_cycle, design_phase: @case_studies.design_phase, project_domain: @case_studies.project_domain, customer_type: @case_studies.customer_type, user_age: @case_studies.user_age, privacy_level: @case_studies.privacy_level, social_setting: @case_studies.social_setting, description: @case_studies.description }
    assert_redirected_to case_studies_path(assigns(:case_studies))
  end

  test "should destroy case_studies" do
    assert_difference('CaseStudy.count', -1) do
      delete :destroy, id: @case_studies
    end

    assert_redirected_to case_studies_path
  end


end