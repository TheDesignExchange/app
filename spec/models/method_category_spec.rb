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

  it { should respond_to(:update_distance) }
  it { should respond_to(:distance_from) }
  it { should respond_to(:relation_type) }
  it { should respond_to(:update_relation_type) }
  it { should respond_to(:recalc_for_remove) }

  it { should be_valid }

  context "when name is not present" do
    before { method_category.name = "" }
    it { should_not be_valid }
  end

  context "when name is too long" do
    before { method_category.name = "a" * 256 }
    it { should_not be_valid }
  end

  describe "#add_child" do
    let(:child_list) { method_category.children }

    context "when child is valid" do
      before { method_category.add_child(child_a) }

      it "adds child to children list" do
        expect(child_list).to include child_a
      end

      it "sets default distance" do
        expect(method_category.distance_from(child_a)).to eq(1)
      end
    end

    context "when child is not valid" do
      before { method_category.add_child(child_a) }

      it "does not raise error" do
        not_child = "not a child"
        expect(method_category.add_child(not_child)).to_not raise_error
      end
    end

    context "when child is already in list" do
      before { method_category.add_child(child_a) }

      it "does not add child twice" do
        method_category.add_child(child_a)
        expect(child_list.size).to eq(1)
        expect(child_list).to include child_a
      end
    end

    context "when child adds its own child" do
      before do
        method_category.add_child(child_a)
        child_a.add_child(child_b)
      end

      it "adds grandchild to children list" do
        expect(child_list).to include child_b
      end

      it "recalculates correct distances to children" do
        expect(method_category.distance_from(child_b)).to eq(2)
      end
    end

    context "when adding a child with existing children" do
      before do
        child_a.add_child(child_b)
        method_category.add_child(child_a)
      end

      it "adds all children to list" do
        expect(child_list).to include(child_a, child_b)
      end

      it "recalculates correct distances to children" do
        expect(method_category.distance_from(child_a)).to eq(1)
        expect(method_category.distance_from(child_b)).to eq(2)
      end
    end
  end

  describe "#get_children" do
    before do
      method_category.add_child(child_a)
      child_a.add_child(child_b)
    end

    context "when called with default argument" do
      let(:results) { method_category.get_children }
      it "gets immediate children" do
        expect(results).to include child_a
      end

      it "does not get grandchildren" do
        expect(results).to_not include child_b
      end
    end

    context "when called with argument n" do
      let(:results) { method_category.get_children(2) }

      it "gets children at level n" do
        expect(results).to include child_b
      end

      it "does not get children at levels != n" do
        expect(results).to_not include child_a
      end
    end
  end

  describe "#get_children_until" do
    before do
      method_category.add_child(child_a)
      child_a.add_child(child_b)
      parent_a.add_child(method_category)
    end

    it "gets children up to depth n" do
      expect(parent_a.get_children_until(3)).to include(child_a, child_b, method_category)
    end
  end

  describe "#remove_child" do
    before do
      method_category.add_child(child_a)
      child_a.add_child(child_b)
      parent_a.add_child(method_category)
      method_category.remove_child(child_a)
    end

    context "when is child" do
      it "removes relation" do
        expect(method_category.children).to_not include child_a
      end

      it "recalculates grandchildren distances" do
        expect(method_category.distance_from(child_b)).to eq(1)
      end

      it "recalculates grandparent distances" do
        expect(parent_a.distance_from(child_b)).to eq(2)
      end

      it "does not destroy child" do
        expect(MethodCategory.where(id: child_a.id)).to exist
      end
    end

    context "when is not child" do
      before do
        parent_b.add_child(child_b)
        method_category.remove_child(parent_b)
      end

      it "does not remove relations" do
        expect(McRelations.where(parent_id: parent_b.id, child_id: child_b.id)).to exist
      end

      it "does not recalculate distances" do
        expect(parent_b.distance_from(child_b)).to eq(1)
      end
    end
  end

  describe "#add_parent" do
    let(:parent_list) { method_category.parents }

    context "when parent is valid" do
      before { method_category.add_parent(parent_a) }

      it "adds parent to parent list" do
        expect(parent_list).to include parent_a
      end

      it "sets default distance" do
        expect(method_category.distance_from(parent_a)).to eq(1)
      end
    end

    context "when parent is not valid" do
      before { method_category.add_parent(parent_a) }

      it "does not raise error" do
        not_parent = "not a parent"
        expect(method_category.add_parent(not_parent)).to_not raise_error
      end
    end

    context "when parent is already in list" do
      before { method_category.add_parent(parent_a) }

      it "does not add child twice" do
        method_category.add_parent(parent_a)
        expect(parent_list.size).to eq(1)
      end
    end

    context "when parent adds its own parent" do
      before do
        method_category.add_parent(parent_a)
        parent_a.add_parent(parent_b)
      end

      it "adds grandparents to parent list" do
        expect(parent_list).to include parent_b
      end

      it "recalculates correct distances to parents" do
        expect(method_category.distance_from(parent_b)).to eq(2)
      end
    end

    context "when adding a parent with existing parents" do
      before do
        parent_a.add_parent(parent_b)
        method_category.add_parent(parent_a)
      end

      it "adds all parents to list" do
        expect(parent_list).to include(parent_a, parent_b)
      end

      it "recalculates correct distances to parents" do
        expect(method_category.distance_from(parent_a)).to eq(1)
        expect(method_category.distance_from(parent_b)).to eq(2)
      end
    end
  end

  describe "#get_parents" do
    before do
      method_category.add_parent(parent_a)
      parent_a.add_parent(parent_b)
    end

    context "when called with no arguments" do
      let(:results) { method_category.get_parents }
      it "gets immediate parents" do
        expect(results).to include parent_a
      end

      it "does not get grandparents" do
        expect(results).to_not include parent_b
      end
    end

    context "when called with argument n" do
      let(:results) { method_category.get_parents(2) }

      it "gets parents at level n" do
        expect(results).to include parent_b
      end

      it "does not get parents at levels != n" do
        expect(results).to_not include parent_a
      end
    end
  end

  describe "#get_parents_until" do
    before do
      child_a.add_parent(method_category)
      method_category.add_parent(parent_a)
      parent_a.add_parent(parent_b)
    end

    it "gets parents up to depth n" do
      expect(child_a.get_parents_until(3)).to include(parent_a, parent_b, method_category)
    end
  end

  describe "#remove_parent" do
    before do
      method_category.add_parent(parent_a)
      parent_a.add_parent(parent_b)
      child_a.add_parent(method_category)
      method_category.remove_parent(parent_a)
    end

    context "when parent is parent" do
      it "removes relation" do
        expect(method_category.children).to_not include parent_a
      end

      it "recalculates grandparents distances" do
        expect(method_category.distance_from(parent_b)).to eq(1)
      end

      it "recalculates grandchildren distances" do
        expect(child_a.distance_from(parent_b)).to eq(2)
      end

      it "does not destroy parent" do
        expect(MethodCategory.where(id: parent_a.id)).to exist
      end
    end

    context "when is not parent" do
      before do
        child_b.add_parent(parent_b)
        method_category.remove_parent(parent_b)
      end

      it "does not remove relations" do
        expect(McRelations.where(parent_id: parent_b.id, child_id: child_b.id)).to exist
      end

      it "does not recalculate distances" do
        expect(parent_b.distance_from(child_b)).to eq(1)
      end
    end
  end

end