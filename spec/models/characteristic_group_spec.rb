require 'rails_helper'

RSpec.describe CharacteristicGroup, :type => :model do
  let(:group) { FactoryGirl.create(:characteristic_group) }

  subject { group }

  it { should respond_to(:name) }
  it { should respond_to(:method_category) }
  it { should respond_to(:characteristics) }
  it { should respond_to(:design_methods) }
end
