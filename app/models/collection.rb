# == Schema Information
#
# Table name: collections
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  is_private :boolean
#  overview   :text
#  owner_id   :integer
#

class Collection < ActiveRecord::Base
  attr_accessible :name, :owner_id, :overview, :is_private, :design_method_ids, :case_study_ids
  after_initialize :init
  has_many :case_studies
  belongs_to :owner, class_name: "User", foreign_key: :owner_id

  has_many :method_collections, dependent: :destroy
  has_many :design_methods, -> { distinct }, through: :method_collections
  has_many :case_studies, -> { distinct }, through: :method_collections

  validates :name, presence: true
    validates :name,  length: { maximum: 255,
                      too_long: "%{count} is the maximum character length."}

  def init
    if self.is_private.nil?
      self.is_private = true
    end
  end
end
