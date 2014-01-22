require 'test_helper'

class DesignMethodsControllerTest < ActionController::TestCase
  setup do
    @design_method = design_methods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:design_methods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create design_method" do
    assert_difference('DesignMethod.count') do
      post :create, design_method: { citation_id: @design_method.citation_id, name: @design_method.name, overview: @design_method.overview, principle: @design_method.principle, process: @design_method.process }
    end

    assert_redirected_to design_method_path(assigns(:design_method))
  end

  test "should show design_method" do
    get :show, id: @design_method
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @design_method
    assert_response :success
  end

  test "should update design_method" do
    put :update, id: @design_method, design_method: { citation_id: @design_method.citation_id, name: @design_method.name, overview: @design_method.overview, principle: @design_method.principle, process: @design_method.process }
    assert_redirected_to design_method_path(assigns(:design_method))
  end

  test "should destroy design_method" do
    assert_difference('DesignMethod.count', -1) do
      delete :destroy, id: @design_method
    end

    assert_redirected_to design_methods_path
  end
end
