require 'test_helper'

class DesignMethodIndexTest < IntegrationTestCase
  setup do 
    @user = users(:one)
  end 

  test "index including similar characteristics" do
    sign_in @user
    get character_design_methods_path  
    # not sure what the div class is supposed to be called? There are multiple
    # called div.col-xs-6
    # assert_select 'div.similar-characteristics' ?? make a new class? 
    assert_select 'div.col-xs-6'
    DesignMethod.index.each do |characteristic|
      assert_select 'a[href=?]', character_design_methods_path(character_design_method), text: characteristic.name
    end
  end 

end
