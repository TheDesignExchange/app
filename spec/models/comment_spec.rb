require 'spec_helper'

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
      comment.replies.should contain(reply)
    end
  end
end
