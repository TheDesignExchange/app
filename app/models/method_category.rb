# == Schema Information
#
# Table name: method_categories
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  process_order :integer
#

class MethodCategory < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 255,
            too_long: "%{count} is the maximum character length."}
  attr_accessible :name
  has_many :characteristic_groups
  has_many :characteristics, through: :characteristic_groups
  has_many :design_methods, -> { uniq }, through: :characteristics
  # Hacky approach to setting default values for process order without
  # revisiting the seed files

  def process_order
    po = read_attribute(:process_order)
    if po == nil
      po = process_order_LUT[name.to_sym]
      self.process_order = po
      save
    end
    return po
  end

  # Indicates the order in which design methods are used in the design process,
  # used for sorting categories in search results filters
  def process_order_LUT
    {Research: 1,
     Analyze: 2,
     Ideate: 3,
     Build: 4,
     Communicate: 5}
  end
end
