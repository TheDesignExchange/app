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

class MethodCaseStudy < ActiveRecord::Base
	belongs_to :case_study
	belongs_to :design_method
	validates_uniqueness_of :case_study, :scope => [:design_method]
end
