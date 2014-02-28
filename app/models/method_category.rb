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
  before_destroy :changedistance
  validates :name, presence: true, length: { maximum: 255,
            too_long: "%{count} is the maximum character length."}

  #Retrieves all children with a distance <= DEPTH. Default is immediate children (depth = 1).
  #To get all children, use self.children instead.
  def getchildren(depth = 1)
    to_return = Array.new
    self.children.each do |c|
      if c.distance <= depth
        to_return << c
      end
    end
    return to_return
  end

  #Retrieves all parents with a distance <= DEPTH. Default is immediate parents (depth = 1).
  #To get all parents, use self.parents instead.
  def getparents(depth = 1)
    to_return = Array.new
    self.parents.each do |c|
      if c.distance <= depth
        to_return << c
      end
    end
    return to_return
  end

  #Creates relation between self and CHILD, modifies distances from any parents of SELF to CHILD
  def addchild(child, distance = 1, type = "subclass")
    McRelations.find_or_create_by(parent_id: self.id, child_id: child.id) do |r|
      r.distance = distance
      r.description = type
    end

    self.ancestors.each do |a|
      new_dist = a.distance + distance
      McRelations.find_or_create_by(parent_id: a.parent_id, child_id: child.id) do |u|
        u.distance = new_dist
        u.description = type
      end
    end
  end

  #Creates relation between self and PARENT, modifies distances from any children of self to PARENT
  def addparent(parent, distance = 1, type = "subclass")
    McRelations.find_or_create_by(parent_id: parent.id, child_id: child.id) do |r|
      r.distance = distance
      r.description = description
    end

    self.descendants.each do |c|
      new_dist = c.distance + distance
      McRelations.find_or_create_by(parent_id: c.id, child_id: self.id)do |u|
        u.distance = new_dist
        u.description = type
      end
    end
  end

  # Removes CHILD from SELF's list of children. Modifies distances from any children or parents of self.
  def removechild(child)
    self.children.destroy(child)
  end

  # Removes parent from SELF's list of parents. Modifies distances from any parents or children of self.
  def removeparent(parent)
    self.parents.destroy(parent)
  end

  def changedistance
    self.descendants.each do |d|
      self.ancestors.each do |a|
        dist = McRelations.find_by(parent_id: a.parent_id, child_id: d.child_id)
        if !dist.empty?
          if dist.distance > d.distance
            dist.distance -= d.distance
            dist.save
          end
        end
      end
    end
  end

  def distance(other, parent = true)
    if parent
      relation = McRelations.find_by(parent_id: self.id, child_id: other.id)
    else
      relation = McRelations.find_by(parent_id: other.id, child_id: self.id)
    end
      return relation.distance
  end

  def updatedist(other, distance, parent = true)
    old_distance = self.distance(other, parent)
    if parent
      update_relation = McRelations.find_by(parent_id: self.id, child_id: other.id)
    else
      update_relation = McRelations.find_by(parent_id: other.id, child_id: self.id)
    end
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
