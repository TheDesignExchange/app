# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)      default("")
#  domain     :string(255)      default("")
#  email      :string(255)      default("")
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Company do
  let(:company) {FactoryGirl.create(:company)}

  subject { company }

  it { should respond_to(:name) }
  it { should respond_to(:domain) }
  it { should respond_to(:email) }

  it { should respond_to(:case_studies) }
  it { should respond_to(:contacts) }

  it { should be_valid }

  describe "when name is not present" do
  	before { company.name = " " }
  	it { should_not be_valid }
  end

  describe "when domain is not present" do
  	before { company.domain = " " }
  	it { should_not be_valid }
  end

  describe "when email is not present" do
  	before { company.email = " " }
  	it { should_not be_valid }
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[company@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        company.email = valid_address
        expect(company).to be_valid
      end
    end
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[company@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        company.email = invalid_address
        expect(company).not_to be_valid
      end
    end
  end

  describe "when name is already taken" do
    before do
      company_with_same_name = company.dup
      company_with_same_name.save
    end

    it { should_not be_valid }
  end
end
