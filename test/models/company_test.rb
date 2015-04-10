# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  domain     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class CompaniesTest < ActiveSupport::TestCase 
	setup do 
		@company = companies(:one)
	end 

	test "should be valid" do
		assert @company.valid?
	end
end 
