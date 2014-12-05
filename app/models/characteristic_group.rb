class CharacteristicGroup < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 255,
          too_long: "%{count} is the maximum character length."}

  belongs_to :method_category
  has_many :characteristics, :primary_key => "characteristic_group_id"
  has_many :design_methods, through: :characteristics
end
