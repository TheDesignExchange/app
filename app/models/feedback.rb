class Feedback
	include ActiveModel::Model
	attr_accessor :name, :email, :subject, :content
	validates :name, :email, :subject, :content, presence: true
end
