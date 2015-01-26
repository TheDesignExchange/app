# == Schema Information
#
# Table name: method_variations
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  variant_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class MethodVariation < ActiveRecord::Base
  attr_accessible :user_id, :design_method_id
  validates :parent_id,
            :variant_id,
              presence: true,
              numericality: { only_integer: true }
  belongs_to :parent, class_name: "DesignMethod"
  belongs_to :variant, class_name: "DesignMethod"
end
