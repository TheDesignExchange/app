class MethodCategoryCaseStudy < ActiveRecord::Base
	belongs_to :case_study
	belongs_to :method_category
	# validates :case_study, :uniqueness => {:scope => :design_method }
	attr_accessible :method_category_id, :case_study_id
	# validates :method_category_id, :presence => true
	# validates :case_study_id, :presence => true
	# attr_accesssible :case_study_id, :design_method_id
end
