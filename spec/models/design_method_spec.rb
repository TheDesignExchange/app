# == Schema Information
#
# Table name: design_methods
#
#  id                 :integer          not null, primary key
#  name               :string(255)      not null
#  overview           :text             not null
#  process            :text             not null
#  aka                :string(255)
#  owner_id           :integer          not null
#  created_at         :datetime
#  updated_at         :datetime
#  num_of_designers   :integer          default(1)
#  num_of_users       :integer          default(1)
#  time_period        :integer          default(0)
#  time_unit          :string(255)      default("")
#  main_image         :string(255)
#  likes              :integer          default(0)
#  synonyms           :text
#  benefits           :text
#  limitations        :text
#  skills             :text
#  usage              :text
#  tools              :text
#  history            :text
#  critiques          :text
#  additional_reading :text
#

require 'rails_helper'

describe DesignMethod do
  let(:user) { FactoryGirl.create(:user) }
  let(:design_method) { FactoryGirl.build(:design_method, owner: user) }

  subject { design_method }

  it { should respond_to(:name) }
  it { should respond_to(:overview) }
  it { should respond_to(:process) }
  it { should respond_to(:owner_id) }

  it { should respond_to(:citations) }
  it { should respond_to(:owner) }
  it { should respond_to(:favorited_users) }
  it { should respond_to(:characteristics)}
  it { should respond_to(:variations)}

  it { should be_valid }

  describe "when name is not present" do
    before { design_method.name = ""}
    it { should_not be_valid }
  end

  describe "when overview is not present" do
    before { design_method.overview = ""}
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { design_method.name = "a" * 256}
    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      same_name = design_method.dup
      same_name.save
    end
    it { should_not be_valid }
  end

  describe "when method has no owner" do
    before { design_method.owner = nil }
    it { should_not be_valid }
  end

  it "when user favorites method" do
    user.favorite(design_method)
    expect(design_method.favorited_users).to include user
  end

  describe "#variations" do
    let(:method2) { FactoryGirl.build(:design_method, owner: user)}
    let(:method3) { FactoryGirl.build(:design_method, owner: user)}
    before { method2.variations << method3 }
    
    context "when a variation is added" do
      before { design_method.variations << method2 }

      it "returns a list of variant methods based on this method" do
        expect(design_method.variations).to include method2
      end

      it "only returns immediate variants" do
        expect(method2.variations).to include method3
        expect(design_method.variations).to_not include method3
      end
    end
  end

  describe "#method_categories" do

    let(:category) { FactoryGirl.create(:method_category) }
    let(:category_2) { FactoryGirl.create(:method_category) }
    let(:group) { FactoryGirl.build(:characteristic_group, method_category: category) }
    let(:characteristic) { FactoryGirl.build(:characteristic, characteristic_group: group) }
    let(:characteristic_2) { FactoryGirl.create(:characteristic, characteristic_group: group) }
    before { design_method.characteristics << characteristic }

    it "returns a list of categories the method belongs to" do
      expect(design_method.method_categories).to include category
    end

    context "when a new characteristic with same category is added" do
      before { design_method.characteristics << characteristic_2 }

      it "does not return multiple of same category" do
        expect(design_method.method_categories.size).to eq(1)
        expect(design_method.method_categories).to include category
      end
    end

    context "when a method does not belong to a category" do

      it "does not return the category" do
        expect(design_method.method_categories).to_not include category_2
      end
    end

    context "when a method has a characteristic that updates its category" do
      before { characteristic.characteristic_group.method_category = category_2 }

      it "returns the new category" do
        expect(design_method.method_categories).to include category_2
      end

      it "does not return the old category" do
        expect(design_method.method_categories).to_not include category
      end
    end

    context "when a method removes the one characteristic from a category" do
      before {design_method.characteristics.delete(characteristic)}

      it "removes the method from the list" do
        expect(design_method.method_categories).to be_empty
      end
    end

    context "when a method removes a non-category unique characteristic" do
      before do
        design_method.characteristics << characteristic_2
        design_method.characteristics.destroy(characteristic)
      end

      it "does not remove the method from the list" do
        expect(design_method.method_categories).to include category
      end
    end
  end
end
