require 'rails_helper'

RSpec.describe Characteristic, :type => :model do
  let(:characteristic) { FactoryGirl.create(:characteristic) }

  subject { characteristic }

  it { should respond_to(:name) }
  it { should respond_to(:characteristic_group)}
  
end
