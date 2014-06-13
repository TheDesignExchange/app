class MethodCaseStudy < ActiveRecord::Base
	belongs_to :case_study
	belongs_to :design_method
	validates_uniqueness_of :case_study, :scope => [:design_method]
end
