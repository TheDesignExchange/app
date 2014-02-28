# == Schema Information
#
# Table name: mc_relations
#
#  id          :integer          not null, primary key
#  parent_id   :integer
#  child_id    :integer
#  distance    :integer
#  description :string(255)      default("subclass")
#  created_at  :datetime
#  updated_at  :datetime
#

class McRelations < ActiveRecord::Base
  belongs_to :parent, :class_name => "MethodCategory"
  belongs_to :child, :class_name => "MethodCategory"
end
