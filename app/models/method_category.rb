# == Schema Information
#
# Table name: method_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class MethodCategory < ActiveRecord::Base
  before_destroy :recalc_distance
  validates :name, presence: true, length: { maximum: 255,
            too_long: "%{count} is the maximum character length."}

  #Retrieves all children with a distance == DEPTH. Default is immediate children (depth = 1).
  #To get all children, use self.children instead.
  def get_children(depth = 1)
    to_return = Array.new
    self.children.each do |child|
      if self.distance_from(child) == depth
        to_return << child
      end
    end
    return to_return
  end

  #Retrieves all children with a distance <= DEPTH. Default is immediate children (depth = 1).
  #To get all children, use self.children instead.
  def get_children_until(depth = 1)
    to_return = Array.new
    self.children.each do |child|
      if self.distance_from(child) <= depth
        to_return << child
      end
    end
    return to_return
  end

  #Retrieves all parents with a distance == DEPTH. Default is immediate parents (depth = 1).
  #To get all parents, use self.parents instead.
  def get_parents(depth = 1)
    to_return = Array.new
    self.parents.each do |parent|
      if parent.distance_from(self) == depth
        to_return << parent
      end
    end
    return to_return
  end

  #Retrieves all parents with a distance <= DEPTH. Default is immediate parents (depth = 1).
  #To get all parents, use self.parents instead.
  def get_parents_until(depth = 1)
    to_return = Array.new
    self.parents.each do |parent|
      if parent.distance_from(self) <= depth
        to_return << parent
      end
    end
    return to_return
  end

  #Creates relation between self and CHILD, modifies distances from any parents of SELF to CHILD
  def add_child(child, distance = 1, type = "subclass")
    if !self.children.exists?(child)
      self.children << child
    end
    self.update_all_fields(child, distance, type)

    self.parents.each do |parent|
      if !parent.children.exists?(child)
        parent.children << child
      end
      offset = parent.distance_from(self)
      parent.update_all_fields(child, distance + offset, type)
    end
  end

  #Creates relation between self and PARENT, modifies distances from any children of self to PARENT
  def add_parent(parent, distance = 1, type = "subclass")
    if !self.parents.exists?(parent)
      self.parents << parent
    end
    self.update_all_fields(parent, distance, type)

    self.children.each do |child|
      if !child.parents.exists?(parent)
        child.parents << parent
      end
      offset = self.distance_from(child)
      child.update_all_fields(parent, distance + offset, type)
    end
  end

  # Removes CHILD from SELF's list of children. Modifies distances from any children or parents of self.
  def remove_child(child)
    self.children.destroy(child)
  end

  # Removes parent from SELF's list of parents. Modifies distances from any parents or children of self.
  def remove_parent(parent)
    self.parents.destroy(parent)
  end

  # Gets the distance from SELF to OTHER.
  def distance_from(other)
    relation = self.return_relation(other)
    if relation
      return relation.distance
    end
  end

  # Updates the distance from SELF to OTHER.
  def update_distance(other, distance)
    update_relation = self.return_relation(other)
    if update_relation
      update_relation.distance = distance
      update_relation.save
      return update_relation.distance
    end
  end

  # Returns the type of relation between SELF and OTHER, where SELF is the parent.
  def relation_type(other)
    relation = self.return_relation(other)
    if relation
      return relation.description
    end
  end

  # Updates the type of relation between SELF and OTHER.
  def update_relation_type(other, type)
    update_relation = self.return_relation(other)
    if update_relation
      update_relation.description = type
      update_relation.save
      return update_relation.description
    end
  end

  # Updates DISTANCE and TYPE of relation for SELF and OTHER.
  def update_all_fields(other, distance, type)
    update_relation = self.return_relation(other)
    update_relation.description = type
    update_relation.distance = distance
    update_relation.save
  end

  # Returns the relation between SELF and OTHER.
  def return_relation(other)
    relation = McRelations.where(parent_id: self.id, child_id: other.id).first
    if !relation
      relation = McRelations.where(parent_id: other.id, child_id: self.id).first
    end
    return relation
  end

  def recalc_distance(to_remove)
    to_remove.parents.each do |parent|
      to_remove.children.each do |child|
        old_dist = parent.distance_from(child)
        offset = parent.distance_from(to_remove)
        parent.update_distance(child, old_dist - offset)
      end
    end
  end


  has_many :child_relations,  :class_name => "McRelations",
                              :foreign_key => "parent_id",
                              :dependent => :destroy
  has_many :children, :through => :child_relations,
                      :source => :child,
                      :before_remove => :recalc_distance
  has_many :parent_relations, :class_name => "McRelations",
                              :foreign_key => "child_id",
                              :dependent => :destroy
  has_many :parents,  :through => :parent_relations,
                      :source => :parent,
                      :before_remove => :recalc_distance

  has_many :categorizations, dependent: :destroy
  has_many :design_methods, through: :categorizations

end
