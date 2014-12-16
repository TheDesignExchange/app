class Characteristic < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 255,
            too_long: "%{count} is the maximum character length."}

  def method_category
    if self.characteristic_group
      return self.characteristic_group.method_category
    end
  end

            
  belongs_to :characteristic_group
  has_many :method_characteristics, dependent: :destroy
  has_many :design_methods, through: :method_characteristics
end
