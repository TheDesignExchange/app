class Tag < ActiveRecord::Base
	attr_accessible :design_method_id, :case_study_id, :discussion_id, :user_id, :content
	# belongs_to :design_method
	# belongs_to :case_study
	# belongs_to :discussion
	# belongs_to :user
end
