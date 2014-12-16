require 'rails_helper'

RSpec.describe Characteristic, :type => :model do
  let(:characteristic) { FactoryGirl.create(:characteristic) }

  subject { characteristic }

  it { should respond_to(:name) }
  it { should respond_to(:characteristic_group)}

  describe '#method_category' do
    let(:category) { FactoryGirl.create(:method_category) }
    let(:category_2) { FactoryGirl.create(:method_category) }
    let(:group) { FactoryGirl.build(:characteristic_group, method_category: category) }

    context "when the characteristic_group is not set" do
      before { characteristic.characteristic_group = nil }
      
      it "returns nil" do
        expect(characteristic.method_category).to be_nil
      end
    end

    context "when the characteristic_group is set" do
      before { characteristic.characteristic_group = group }

      it "returns the correct category" do
        expect(characteristic.method_category).to be(category)
      end
    end

    context "when the characteristic_group changes" do
      before do
        characteristic.characteristic_group = group
        group.method_category = category_2
      end

      it "returns correct category" do
        expect(characteristic.method_category).to be(category_2)
      end
    end

  end
end
