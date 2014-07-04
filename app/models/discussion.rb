class Discussion < ActiveRecord::Base
  validates :title, :description, :user, presence: true

  validates_uniqueness_of :title
  belongs_to :user
  has_many :replies, class_name: "DiscussionReply"
end
