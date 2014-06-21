# == Schema Information
#
# Table name: method_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe MethodCategory do
  # TODO: add relationship tests
  let(:method_category) { FactoryGirl.create(:method_category) }

  subject { method_category }

  it { should respond_to(:name) }

  it { should respond_to(:design_methods) }

  it { should be_valid }

  context "when name is not present" do
    before { method_category.name = "" }
    it { should_not be_valid }
  end

  context "when name is too long" do
    before { method_category.name = "a" * 256 }
    it { should_not be_valid }
  end

end