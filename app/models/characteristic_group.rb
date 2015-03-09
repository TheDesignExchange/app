# == Schema Information
#
# Table name: characteristic_groups
#
#  id                 :integer          not null, primary key
#  method_category_id :integer
#  name               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class CharacteristicGroup < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 255,
          too_long: "%{count} is the maximum character length."}

  belongs_to :method_category
  has_many :characteristics
  has_many :design_methods, -> { uniq }, through: :characteristics
end
