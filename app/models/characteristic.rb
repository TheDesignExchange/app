# == Schema Information
#
# Table name: characteristics
#
#  id                      :integer          not null, primary key
#  characteristic_group_id :integer
#  name                    :string(255)
#  description             :text             default("")
#  created_at              :datetime
#  updated_at              :datetime
#

class Characteristic < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 255,
            too_long: "%{count} is the maximum character length."}


  belongs_to :characteristic_group
  has_many :method_characteristics, dependent: :destroy
  has_many :design_methods, through: :method_characteristics

  def method_category
    if self.characteristic_group
      return self.characteristic_group.method_category
    end
  end
end
