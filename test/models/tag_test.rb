# == Schema Information
#
# Table name: tags
#
#  id               :integer          not null, primary key
#  design_method_id :integer
#  case_study_id    :integer
#  discussion_id    :integer
#  user_id          :integer
#  content          :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  content_type     :string(255)      default("tag")
#

require 'test_helper'

class TagTest < ActiveSupport::TestCase 
	setup do 
		@tag = tags(:one)
	end 

	test "should be valid" do
		assert @tag.valid?
	end
end 