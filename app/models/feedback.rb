class Feedback
	include ActiveModel::Model
	attr_accessor :name, :email, :subject, :content
	validates :content, presence: true
end
