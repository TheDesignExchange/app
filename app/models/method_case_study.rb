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
	# validates :case_study, :uniqueness => {:scope => :design_method }
	attr_accessible :design_method_id, :case_study_id
	validates :case_study_id, :presence => true
	validates :design_method_id, :presence => true
	# attr_accesssible :case_study_id, :design_method_id
end
