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

require 'rails_helper'

describe DiscussionReply do
  let (:user) { FactoryGirl.create(:user) }
  let (:reply_user) { FactoryGirl.create(:user) }
  let (:discussion) { FactoryGirl.create(:discussion, user: user) }
  let (:discussion_reply) { FactoryGirl.create(:discussion_reply, user: reply_user, discussion: discussion) }

  subject { discussion_reply }

  it { should respond_to :text }
  it { should respond_to :user }
  it { should respond_to :discussion }
  it { should respond_to :parent }

  it "should be part of the discussion's replies" do
    expect(discussion.replies).to include discussion_reply
  end

  describe "when adding a reply" do
    let (:new_reply) { FactoryGirl.create(:discussion_reply, user: user, discussion: discussion) }

    before do
      discussion_reply.reply(new_reply)
    end

    it "should be part of the original reply's replies" do
      expect(discussion_reply.replies).to include new_reply
    end
  end
end

