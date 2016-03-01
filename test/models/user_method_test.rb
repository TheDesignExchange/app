# == Schema Information
#
# Table name: user_methods
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  design_method_id :integer          not null
#  type_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#


require 'test_helper'

class UserMethodTest < ActiveSupport::TestCase 
	setup do 
		@user_method = user_methods(:one)
	end 

	test "user_id should be present" do
		@user_method.user_id = "   "
		assert_not @user_method.valid?
	end

	test "design_method_id should be present" do
		@user_method.design_method_id = "   "
		assert_not @user_method.valid?
	end

	test "type_id should be present" do
		@user_method.type_id = "   "
		assert_not @user_method.valid?
	end
end