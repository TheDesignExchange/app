# == Schema Information
#
# Table name: method_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe MethodCategory do
  # TODO: add relationship tests
  let(:method_category) { FactoryGirl.create(:method_category) }

  subject { method_category }

  it { should respond_to(:name) }

  it { should be_valid }

  describe "name is not present" do
    before { method_category.name = "" }
    it { should_not be_valid }
  end

  describe "name is too long" do
    before { method_category.name = "a" * 256 }
    it { should_not be_valid}
  end
end
