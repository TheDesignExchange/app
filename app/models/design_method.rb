# == Schema Information
#
# Table name: design_methods
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  overview   :text             not null
#  process    :text             not null
#  principle  :text             not null
#  owner_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class DesignMethod < ActiveRecord::Base
  validates :name, :overview, presence: true
  validates :name, length: { maximum: 255,
            too_long: "%{count} is the maximum character length."}
  validates :name, uniqueness: { case_sensitive: false,
            message: "Already exists. Try editing an existing one."},
            on: :create
  validates :owner_id, presence: true

  searchable do
    text :name, stored: true
    text :overview, stored: true
    text :principle, stored: true
    text :process, stored: true
    text :method_categories do
      method_categories.map { |method_category| method_category.name }
    end
  end

  def overview
    if self[:overview] == "default"
      self[:overview] = "No overview available"
    end
    return self[:overview]
  end

  def process
    if self[:process] == "default"
      self[:process] = "No process available"
    end
    return self[:process]
  end

  has_many :categorizations, dependent: :destroy
  has_many :method_categories, through: :categorizations
  has_many :method_citations, dependent: :destroy
  has_many :citations, through: :method_citations
  has_many :method_favorites, dependent: :destroy
  has_many :favorited_users, through: :method_favorites, :source => :user
  belongs_to :owner, class_name: "User", foreign_key: :owner_id

  # CASE STUDY LINKING 
  has_many :method_case_studies
  has_many :case_studies, :through => :method_case_studies

  # Method variations
  has_many :variations, class_name: "DesignMethod", foreign_key: :parent_id
  belongs_to :parent, class_name: "DesignMethod"

  # Comments
  has_many :comments, dependent: :destroy

end 