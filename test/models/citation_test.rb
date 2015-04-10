# == Schema Information
#
# Table name: citations
#
#  id         :integer          not null, primary key
#  text       :text
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class CitationTest < ActiveSupport::TestCase 
	setup do 
		@citation = citations(:one)
	end 

	test "should be valid" do
		assert @citation.valid?
	end
end 