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

require 'rails_helper'

describe User do
  let(:user) {FactoryGirl.create(:user)}

  subject { user }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:username) }

  it { should respond_to(:profile_picture) }
  it { should respond_to(:phone_number) }

  it { should respond_to(:website) }
  it { should respond_to(:facebook) }
  it { should respond_to(:twitter) }
  it { should respond_to(:linkedin) }

  it { should respond_to(:about_text) }

  it { should respond_to(:email) }
  it { should respond_to(:encrypted_password) }

  it { should respond_to(:favorite_methods) }
  it { should respond_to(:owned_methods) }

  it { should respond_to(:favorite) }

  it { should be_valid }

  describe "when email is not present" do
    before { user.email = " " }
    it { should_not be_valid }
  end

  describe "when password is too short" do
    before do
      user.password = "short"
      user.password_confirmation = "short"
      user.save
    end
    it {should_not be_valid}
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end
end
