class Discussion < ActiveRecord::Base
  validates :title, :description, :user, presence: true

  belongs_to :user
  has_many :replies, class_name: "DiscussionReply"
end
