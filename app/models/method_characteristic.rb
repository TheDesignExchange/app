# == Schema Information
#
# Table name: method_characteristics
#
#  id                :integer          not null, primary key
#  design_method_id  :integer
#  characteristic_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class MethodCharacteristic < ActiveRecord::Base
	validates :design_method_id,
            :characteristic_id,
              presence: true,
              numericality: { only_integer: true }
              
  belongs_to :design_method
  belongs_to :characteristic
end
