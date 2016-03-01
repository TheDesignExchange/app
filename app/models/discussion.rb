# == Schema Information
#
# Table name: discussions
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  user_id     :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Discussion < ActiveRecord::Base
  attr_accessible :name, :description, :user_id
  validates :name, :description, :user, presence: true
  validates :user_id, presence: true

  validates_uniqueness_of :name
  belongs_to :user
  has_many :replies, class_name: "DiscussionReply"
  has_many :tags

  # Sunspot
  searchable do
    text :name, stored: true
    text :description, stored: true
  end

  def tags
    Tag.where("discussion_id = ? and content_type = ?", self[:id], "tag");
  end

  def tools
      Tag.where("discussion_id = ? and content_type = ?", self[:id], "tool");
  end
end
