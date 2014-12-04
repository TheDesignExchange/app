class MethodCharacteristic < ActiveRecord::Base
	validates :design_method_id,
            :characteristic_id,
              presence: true,
              numericality: { only_integer: true }
              
  belongs_to :design_method
  belongs_to :characteristic
end
