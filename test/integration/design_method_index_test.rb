require 'test_helper'

class DesignMethodIndexTest < IntegrationTestCase
  setup do 
    @user = users(:one)
  end 

  test "index including pagination" do
    sign_in @user
    get character_design_methods_path 
  end 
