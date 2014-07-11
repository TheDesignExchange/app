# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)      default("")
#  email      :string(255)      default("")
#  phone      :string(255)      default("")
#  company_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Contact do
  let(:contact) {FactoryGirl.create(:contact)}

  subject { contact }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:phone) }
  it { should respond_to(:company_id) }

  it { should respond_to(:case_studies) }

  it { should be_valid }

  describe "when name is not present" do
  	before { contact.name = " " }
  	it { should_not be_valid }
  end

  describe "when email is not present" do
  	before { contact.email = " " }
  	it { should_not be_valid }
  end

  describe "when phone is not present" do
  	before { contact.phone = " " }
  	it { should_not be_valid }
  end

  describe "when email address is already taken" do
    before do
      contact_with_same_email = contact.dup
      contact_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when email address is already taken" do
    before do
      contact_with_same_email = contact.dup
      contact_with_same_email.email = contact.email.upcase
      contact_with_same_email.save
    end

    it { should_not be_valid }
  end

end
