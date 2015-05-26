# == Schema Information
#
# Table name: method_case_studies
#
#  id               :integer          not null, primary key
#  case_study_id    :integer
#  design_method_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

require 'test_helper'

class MethodCaseStudyTest < ActiveSupport::TestCase 
	setup do 
		@method_case_study = method_case_studies(:one)
	end 

	test "should be valid" do
		assert @method_case_study.valid?
	end
end 