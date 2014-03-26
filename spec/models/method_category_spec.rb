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
  let(:child_a) { FactoryGirl.create(:method_category) }
  let(:child_b) { FactoryGirl.create(:method_category) }
  let(:parent_a) { FactoryGirl.create(:method_category) }
  let(:parent_b) { FactoryGirl.create(:method_category) }

  subject { method_category }

  it { should respond_to(:name) }

  it { should respond_to(:children) }
  it { should respond_to(:parents) }
  it { should respond_to(:design_methods) }

  it { should respond_to(:add_child) }
  it { should respond_to(:add_parent) }
  it { should respond_to(:remove_child) }
  it { should respond_to(:remove_parent) }
  it { should respond_to(:get_children) }
  it { should respond_to(:get_parents) }
  it { should respond_to(:recalc_distance) }
  it { should respond_to(:update_distance) }
  it { should respond_to(:distance_from) }
  it { should respond_to(:relation_type) }
  it { should respond_to(:update_relation_type) }

  it { should be_valid }

  describe "name is not present" do
    before { method_category.name = "" }
    it { should_not be_valid }
  end

  describe "name is too long" do
    before { method_category.name = "a" * 256 }
    it { should_not be_valid}
  end

  describe "children methods" do
    before do
      method_category.add_child(child_a)
      child_a.add_child(child_b)
    end

    it "should add children" do
      method_category.children.should include child_a
      method_category.distance_from(child_a).should eq(1)
    end

    it "should add grandchildren" do
      method_category.children.should include child_b
      method_category.distance_from(child_b).should eq(2)
    end

    it "should get immediate children" do
      results = method_category.get_children
      results.should include child_a
      results.should_not include child_b
    end

    it "should get specific children" do
      results = method_category.get_children(2)
      results.should include child_b
      results.should_not include child_a
    end

    it "should get all children up to some depth" do
      results = method_category.get_children_until(2)
      results.should include child_a
      results.should include child_b
    end

    it "should remove children" do
      method_category.remove_child(child_a)
      method_category.children.should_not include child_a
      method_category.distance_from(child_b).should eq(1)
    end
  end

  describe "parent methods" do
    before do
      method_category.add_parent(parent_a)
      parent_a.add_parent(parent_b)
    end

    it "should add parents" do
      method_category.parents.should include parent_a
      method_category.distance_from(parent_a).should eq(1)
    end

    it "should add grandparents" do
      method_category.parents.should include parent_b
      method_category.distance_from(parent_b).should eq(2)
    end

    it "should get immediate parents" do
      results = method_category.get_parents
      results.should include parent_a
      results.should_not include parent_b
    end

    it "should get specific parents" do
      results = method_category.get_parents(2)
      results.should include parent_b
      results.should_not include parent_a
    end

    it "should get all parents up until some depth" do
      results = method_category.get_parents_until(2)
      results.should include parent_a
      results.should include parent_b
    end

    it "should remove parents" do
      method_category.remove_parent(parent_a)
      method_category.parents.should_not include parent_a
      method_category.distance_from(parent_b).should eq(1)
    end
  end

end