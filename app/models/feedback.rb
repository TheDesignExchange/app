class Feedback < ActiveRecord::Base
  attr_accessible :title, :body, :email, :feedbacktype #allows mass assignment
  
  validates :title, presence: true, length: { maximum: 100 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
end
