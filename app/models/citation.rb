# == Schema Information
#
# Table name: citations
#
#  id         :integer          not null, primary key
#  text       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Citation < ActiveRecord::Base
  validates :text, presence: true

  has_many :method_citations, dependent: :destroy
  has_many :design_methods, through: :method_citations
end
