# == Schema Information
#
# Table name: method_favorites
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  design_method_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class MethodFavorite < ActiveRecord::Base
  attr_accessible :user_id, :design_method_id
  validates :user_id,
            :design_method_id,
              presence: true,
              numericality: { only_integer: true }
  belongs_to :user
  belongs_to :design_method
end
