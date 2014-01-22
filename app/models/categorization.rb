# == Schema Information
#
# Table name: categorizations
#
#  id                 :integer          not null, primary key
#  design_method_id   :integer
#  method_category_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Categorization < ActiveRecord::Base
  validates :design_method_id, :method_category_id, 
            presence: true, numericality: { only_integer: true }

  belongs_to :design_method
  belongs_to :method_category
end
