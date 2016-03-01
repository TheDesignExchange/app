# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  phone      :string(255)
#  company_id :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class ContactTest < ActiveSupport::TestCase 
	setup do 
		@contact = contacts(:one)
	end 

	test "should be valid" do
		assert @contact.valid?
	end

  test "email should be present" do
    @contact.email = "   "
    assert_not @contact.valid?
  end

  test "name should be present" do
    @contact.name = "   "
    assert_not @contact.valid?
  end

end 