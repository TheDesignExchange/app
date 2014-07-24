# == Schema Information
#
# Table name: method_citations
#
#  id               :integer          not null, primary key
#  design_method_id :integer
#  citation_id      :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class MethodCitation < ActiveRecord::Base
  attr_accessible :design_method_id, :citation_id
  validates :design_method_id,
            :citation_id,
              presence: true,
              numericality: { only_integer: true }

  belongs_to :design_method
  belongs_to :citation
end
