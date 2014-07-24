# == Schema Information
#
# Table name: discussions
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  user_id     :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Discussion < ActiveRecord::Base
  validates :title, :description, :user, presence: true

  validates_uniqueness_of :title
  belongs_to :user
  has_many :replies, class_name: "DiscussionReply"
  has_many :tags
end
