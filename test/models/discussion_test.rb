
# == Schema Information
#
# Table name: discussions
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  user_id     :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class DiscussionTest < ActiveSupport::TestCase
	setup do 
		@discussion = discussions(:one)
	end 

	test "user_id should be present" do
		@discussion.user_id = "  "
		assert_not @discussion.valid?
	end
end