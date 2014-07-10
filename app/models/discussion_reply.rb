# == Schema Information
#
# Table name: discussion_replies
#
#  id                  :integer          not null, primary key
#  text                :text
#  user_id             :integer
#  discussion_id       :integer
#  discussion_reply_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class DiscussionReply < ActiveRecord::Base
  validates :text, :user, :discussion, presence: true

  belongs_to :user
  belongs_to :discussion
  belongs_to :parent, class_name: "DiscussionReply"

  has_many :replies, class_name: "DiscussionReply", foreign_key: :discussion_reply_id

  def reply(discussion_reply)
    if DiscussionReply.exists?(discussion_reply)
      self.replies << discussion_reply
    end
  end

end
