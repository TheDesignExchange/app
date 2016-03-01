# == Schema Information
#
# Table name: method_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class MethodCategoryTest < ActiveSupport::TestCase 
	setup do 
		@method_category = method_categories(:one)
	end 

	test "should be valid" do
		assert @method_category.valid?
	end
end 