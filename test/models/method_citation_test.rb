# == Schema Information
#
# Table name: method_citations
#
#  id               :integer          not null, primary key
#  design_method_id :integer
#  citation_id      :integer
#  created_at       :datetime
#  updated_at       :datetime
#

require 'test_helper'

class MethodCitationTest < ActiveSupport::TestCase 
	setup do 
		@method_citation = method_citations(:balsamiq)
	end 

	test "should be valid" do
		assert @method_citation.valid?
	end
end 