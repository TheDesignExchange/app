# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer          default(0)
#  commentable_type :string(255)
#  title            :string(255)
#  body             :text
#  subject          :string(255)
#  user_id          :integer          default(0), not null
#  parent_id        :integer
#  lft              :integer
#  rgt              :integer
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe Comment do
  let(:user) { FactoryGirl.create(:user) }
  let(:comment) { FactoryGirl.create(:comment, user: user) }
  let(:design_method) { FactoryGirl.create(:design_method, owner: user) }

  subject { comment }

  it { should respond_to(:body) }
  it { should respond_to(:user_id) }
  it { should respond_to(:title) }
  it { should respond_to(:subject) }
  it { should respond_to(:parent_id) }
  it { should respond_to(:lft) }
  it { should respond_to(:rgt) }
  it { should respond_to(:commentable_type) }
  it { should respond_to(:commentable_id) }

  it { should respond_to(:user) }
  it { should respond_to(:commentable) }

  it { should be_valid }

  describe "when body is not present" do
    before { comment.body = "" }
    it {should_not be_valid }
  end

  describe "when user_id is not present" do
    before { comment.user = nil }
    it { should_not be_valid }
  end

  it "when user comments on a method" do
    c = Comment.build_from(design_method, user.id, "This is a comment")
    c.save
    user.commented_methods.should include design_method
  end

end
