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
  before_destroy :change_distance
  validates :name, presence: true, length: { maximum: 255,
            too_long: "%{count} is the maximum character length."}

  #Retrieves all children with a distance <= DEPTH. Default is immediate children (depth = 1).
  #To get all children, use self.children instead.
  def get_children(depth = 1)
    to_return = Array.new
    self.children.each do |child|
      if self.distance_from(child) <= depth
        to_return << child
      end
    end
    return to_return
  end

  #Retrieves all parents with a distance <= DEPTH. Default is immediate parents (depth = 1).
  #To get all parents, use self.parents instead.
  def get_parents(depth = 1)
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

  def change_distance
    self.parents.each do |parent|
      self.children.each do |child|
        old_dist = parent.distance_from(child)
        if old_dist
          offset = parent.distance_from(self)
          parent.update_distance(child, old_dist - offset)
        end
      end
    end
  end

  # Gets the distance from SELF to OTHER, where SELF is the parent in the relationship.
  def distance_from(other)
    relation = McRelations.where(parent_id: self.id, child_id: other.id).first
    if relation
      return relation.distance
    end
  end

  # Updates the distance from SELF to OTHER, where SELF is the parent in the relationship.
  def update_distance(other, distance)
    update_relation = McRelations.where(parent_id: self.id, child_id: other.id).first
    if update_relation
      update_relation.distance = distance
      update_relation.save
      return update_relation.distance
    end
  end

  # Returns the type of relation between SELF and OTHER, where SELF is the parent.
  def relation_type(other)
    relation = McRelations.where(parent_id: self.id, child_id: other.id).first
    if relation
      return relation.description
    end
  end

  # Updates the type of relation between SELF and OTHER, where SELF is the parent.
  def update_relation_type(other, type)
    update_relation = McRelations.where(parent_id: self.id, child_id: other.id).first
    if update_relation
      update_relation.description = type
      update_relation.save
      return update_relation.description
    end
  end

  # Updates DISTANCE and TYPE of relation for SELF and OTHER, where SELF is the parent.
  def update_all_fields(other, distance, type)
    update_relation = McRelations.where(parent_id: self.id, child_id: other.id).first
    update_relation.description = type
    update_relation.distance = distance
    update_relation.save
  end

  has_many :descendants,  :class_name => "McRelations",
                          :foreign_key => "parent_id",
                          :dependent => :destroy
  has_many :children, :through => :descendants, :source => :child
  has_many :ancestors,    :class_name => "McRelations",
                          :foreign_key => "child_id",
                          :dependent => :destroy
  has_many :parents, :through => :ancestors, :source => :parent

  has_many :categorizations, dependent: :destroy
  has_many :design_methods, through: :categorizations

end
