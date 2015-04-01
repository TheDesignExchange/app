# == Schema Information
#
# Table name: citations
#
#  id         :integer          not null, primary key
#  text       :text
#  created_at :datetime
#  updated_at :datetime
#

class Citation < ActiveRecord::Base
  attr_accessible :text
  validates :text, presence: true

  has_many :method_citations, dependent: :destroy
  has_many :design_methods, through: :method_citations

end
