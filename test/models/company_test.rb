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
		@company = companies(:google)
	end 

	test "should be valid" do
		assert @company.valid?
	end  

  test "email should be present" do
    @company.email = "   "
    assert_not @company.valid?
  end

  test "domain should be present" do
    @company.domain = "   "
    assert_not @company.valid?
  end
end 
