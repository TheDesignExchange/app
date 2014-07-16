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
#  first_name             :string(255)
#  last_name              :string(255)
#  username               :string(255)
#  profile_picture        :string(255)
#  phone_number           :string(255)
#  website                :string(255)
#  facebook               :string(255)
#  twitter                :string(255)
#  linkedin               :string(255)
#  about_text             :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

require 'rails_helper'

describe User do
  let(:user) {FactoryGirl.create(:user)}
  let(:design_method) {FactoryGirl.create(:design_method, owner: user)}

  subject { user }

  it { should respond_to(:email) }
  it { should respond_to(:encrypted_password) }

  it { should respond_to(:favorite_methods) }
  it { should respond_to(:owned_methods) }

  it { should respond_to(:favorite) }

  it { should respond_to(:like) }
  it { should respond_to(:unlike) }
  it { should respond_to(:liked?) }

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

  describe "when user likes a design method" do
    it "should create one method like record" do
      method_like = user.like(design_method)
      method_like_list = MethodLike.where(
        user_id: user.id,
        design_method_id: design_method.id
      )

      expect(method_like_list.count).to eq 1
    end
    it "should return the correct method like" do
      method_like = user.like(design_method)
      method_like_list = MethodLike.where(
        user_id: user.id,
        design_method_id: design_method.id
      )

      expect(method_like_list.take).to eq method_like
    end
  end

  describe "when user unlikes a design method" do
    it "should have no method like record" do
      method_like = user.like(design_method)
      user.unlike(design_method)

      method_like_list = MethodLike.where(
        user_id: user.id,
        design_method_id: design_method.id
      )
      
      expect(method_like_list).to be_empty
    end
  end

  describe "when user likes an already liked design method" do
    it "should return false" do
      user.like(design_method)
      method_like = user.like(design_method)

      expect(method_like).to eq false
    end
  end

  describe "when user unlikes a design method not liked" do
    it "should return false" do
      method_like = user.unlike(design_method)

      expect(method_like).to eq false
    end
  end

  describe "when user checks if method is liked" do
    it "should return true" do
      user.like(design_method)

      expect(user.liked?(design_method)).to eq true
    end
    it "should return false" do
      user.like(design_method)

      user.unlike(design_method)
      expect(user.liked?(design_method)).to eq false
    end
    it "should return false" do
      other_method = FactoryGirl.create(:design_method, owner: user)

      expect(user.liked?(other_method)).to eq false
    end
  end
end
