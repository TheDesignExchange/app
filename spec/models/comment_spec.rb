# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  text             :text
#  user_id          :integer
#  design_method_id :integer
#  parent_id        :integer
#  display_order    :integer
#  indent           :integer
#  created_at       :datetime
#  updated_at       :datetime
#

require 'rails_helper'

describe Comment do
  let(:user) { FactoryGirl.create(:user) }
  let(:design_method) { FactoryGirl.create(:design_method, owner: user) }
  let(:comment) { FactoryGirl.create(:comment, user: user, design_method: design_method) }

  subject { comment }

  it { should respond_to(:text) }
  it { should respond_to(:user) }
  it { should respond_to(:design_method) }
  it { should respond_to(:parent) }
  it { should respond_to(:replies) }
  it { should respond_to(:reply) }

  it { should be_valid }

  describe "when replying to comment" do
    let(:reply) { FactoryGirl.create(:comment, user: user, design_method: design_method) }

    before do
      comment.reply(reply)
    end

    it "should have the reply in its replies" do
      expect(comment.replies).to include reply
    end
  end
end
