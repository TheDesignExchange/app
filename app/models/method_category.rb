# == Schema Information
#
# Table name: method_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class MethodCategory < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 255,
            too_long: "%{count} is the maximum character length."}

  has_many :categorizations, dependent: :destroy
  has_many :design_methods, through: :categorizations

end
