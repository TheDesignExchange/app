# == Schema Information
#
# Table name: method_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# STUFF TO CONSIDER:
# currently for add/remove: just removing child from lineage list.
# --if the child gets completely deleted beforehand, then need to change
#   the argument that gets passed (instead of method category, need the id only or something)
# when a method category is created, does the parent id and lineage need to get filled out?
# or should there be some method here that fills that in?
# if a "root" method is added how is everything going to get filled? copy-paste lineage list from child?

class MethodCategory < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 255,
            too_long: "%{count} is the maximum character length."}

  def parent
    return MethodCategory.find(self.parent_id)
  end

  def immediatechildren
    return MethodCategory.where(parent_id: self.id)
  end

  def children(depth = -1)
    to_return = Array.new
    child_list = self.lineage
    child_list.split(",").each do |id|
      child = MethodCategory.find(id.to_i)
      if child && (depth < 0 || child.depth >= depth)
        to_return << child
      end
    end
    return to_return
  end

  def addchild(child)
    if MethodCategory.exists?(child.id)
      self.lineage << ", " << child.id.to_s
    end
  end

  def removechild(child)
    to_remove = MethodCategory.find(child.id)
    if to_remove
      value = child.id.to_s
      regex = /(?:[^\d]|^)#{value}(?:[^\d]|$)/
      self.lineage.slice!(regex)
    end
  end

  has_many :categorizations, dependent: :destroy
  has_many :design_methods, through: :categorizations
end
