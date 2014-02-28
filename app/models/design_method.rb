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
            message: "already exists. Try editing an existing one."},
            on: :create

  searchable do
    text :name, stored: true
    text :overview, stored: true
    text :principle, stored: true
    text :process, stored: true
    text :method_categories do
      method_categories.map { |method_category| method_category.name }
    end
  end

  has_many :categorizations, dependent: :destroy
  has_many :method_categories, through: :categorizations
  has_many :method_citations, dependent: :destroy
  has_many :citations, through: :method_citations

  belongs_to :owner, class_name: "User", foreign_key: :owner_id
end
