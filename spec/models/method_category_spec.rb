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
  before { @category = MethodCategory.new(name: "category") }

  subject { @category }

  it { should respond_to(:name) }

  it { should be_valid}

  describe "name is not present" do
    before { @category.name = "" }
    it { should_not be_valid }
  end

  describe "name is too long" do
    before { @category.name = "a" * 256 }
    it { should_not be_valid}
  end
end
