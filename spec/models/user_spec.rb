# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

require 'spec_helper'

describe User do
  before { @user = User.new(email: "user@example.com", password: "test1234") }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:encrypted_password)}

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when password is too short" do
    before do
      @user = User.create(email: "test#@example.com", password: "short")
    end
    it { should_not be_valid }
  end

  #Read up on devise validation?
  # describe "when email format is invalid" do
  #   it "should be invalid" do
  #     addresses = %w[user@foo,com user_at_foo.org example.user@foo.
  #                    foo@bar_baz.com foo@bar+baz.com]
  #     addresses.each do |invalid_address|
  #       @user.email = invalid_address
  #       expect(@user).not_to be_valid
  #     end
  #   end
  # end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
end
