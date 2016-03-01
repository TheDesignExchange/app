require 'test_helper'

class FeedbackTest < ActiveSupport::TestCase

  def setup
    @feedback = Feedback.new(title: "Example Feedback", body: "Sample Text", email: "user@example.com")
  end

  test "should be valid" do
    assert @feedback.valid?
  end
  
  test "title should be present" do
    @feedback.title = "     "
    assert_not @feedback.valid?
  end
  
  test "title should not be too long" do
    @feedback.title = "a" * 101
    assert_not @feedback.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @feedback.email = valid_address
      assert @feedback.valid?, "#{valid_address.inspect} should be valid"
    end
  end
end
