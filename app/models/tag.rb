class Tag < ActiveRecord::Base
	attr_accessible :design_method_id, :case_study_id, :discussion_id, :user_id, :content, :content_type
	belongs_to :design_method
	belongs_to :case_study
	belongs_to :discussion
	belongs_to :user
	before_save { self.content = content.downcase.gsub(' ', '_') }
	validates :content, :uniqueness => { :scope => [ "case_study_id", "design_method_id", "discussion_id", "content_type"]}
end
