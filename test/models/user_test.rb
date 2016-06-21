# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  username               :string(255)
#  profile_picture        :string(255)
#  phone_number           :string(255)
#  website                :string(255)
#  facebook               :string(255)
#  twitter                :string(255)
#  linkedin               :string(255)
#  about_text             :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  roles_mask             :integer
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase 
  setup do 
    @user = users(:jack)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "encrypted_password should be present" do
    @user.encrypted_password = "   "
    assert_not @user.valid?
  end

  test "sign_in_count should be present" do
    @user.sign_in_count = "   "
    assert_not @user.valid?
  end

  test "associated design_methods should be destroyed" do
    @user.owned_methods
    assert_difference 'DesignMethod.count', -1 do 
      @user.destroy
    end 
  end 


end
