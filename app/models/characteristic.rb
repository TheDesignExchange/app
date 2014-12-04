class Characteristic < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 255,
            too_long: "%{count} is the maximum character length."}
            
  belongs_to :characteristic_group
  has_many :method_characteristics, dependent: :destroy
  has_many :design_methods, through: :method_characteristics
end
