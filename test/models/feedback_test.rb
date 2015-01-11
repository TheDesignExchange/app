require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase

  def setup
    @feedback = Feedback.new(title: "Example Feedback", body: "Sample Text")
  end

  test "should be valid" do
    assert @feedback.valid?
  end
  
  test "title should be present" do
    @feedback.title = "     "
    assert_not @feedback.valid?
  end
  
  test "title should not be too long" do
    @feedback.name = "a" * 101
    assert_not @feedback.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
end
