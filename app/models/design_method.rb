# == Schema Information
#
# Table name: design_methods
#
#  id                 :integer          not null, primary key
#  name               :string(255)      not null
#  overview           :text             not null
#  process            :text             not null
#  aka                :string(255)
#  owner_id           :integer          not null
#  created_at         :datetime
#  updated_at         :datetime
#  num_of_designers   :integer          default(1)
#  num_of_users       :integer          default(1)
#  time_period        :integer          default(0)
#  time_unit          :string(255)      default("")
#  main_image         :string(255)
#  likes              :integer          default(0)
#  synonyms           :text
#  benefits           :text
#  limitations        :text
#  skills             :text
#  usage              :text
#  tools              :text
#  history            :text
#  critiques          :text
#  additional_reading :text
#

class DesignMethod < ActiveRecord::Base

  # TODO: add the mass assignment protection at the controller, then remove this
  attr_accessible :name, :process, :num_of_designers, :num_of_users, :overview, :main_image, :time_period, :name, :time_unit

  # Validations
  validates :name, :overview, presence: true
  validates :name, length: { maximum: 255,
            too_long: "%{count} is the maximum character length."}
  validates :name, uniqueness: { case_sensitive: false,
            message: "Already exists. Try editing an existing one."},
            on: :create
  validates :owner_id, presence: true
  validates :process, presence: true

  # Relationships
  has_many :method_characteristics, dependent: :destroy
  has_many :characteristics, through: :method_characteristics

  has_many :method_citations, dependent: :destroy
  has_many :citations, through: :method_citations

  has_many :method_favorites, dependent: :destroy
  has_many :favorited_users, through: :method_favorites, :source => :user

  belongs_to :owner, class_name: "User", foreign_key: :owner_id

  # CASE STUDY LINKING
  has_many :method_case_studies
  has_many :case_studies, :through => :method_case_studies

  # Method variations
  has_many :method_variations, foreign_key: "parent_id", dependent: :destroy
  has_many :variations, -> { uniq }, through: :method_variations, source: :variant

  # Comments
  has_many :comments, dependent: :destroy
  has_many :tags

  # Uploader (what gem?)
  mount_uploader :main_image, PictureUploader

  # Sunspot
  searchable do
    text :name, stored: true
    text :overview, stored: true
    text :process, stored: true

    text :method_categories do
      method_categories.map { |method_category| method_category.name }
    end

    text :characteristics do
      characteristics.map { |characteristic| characteristic.name }
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

  def tags
    Tag.where("design_method_id = ? and content_type = ?", self[:id], "tag");
  end

  def tools
    Tag.where("design_method_id = ? and content_type = ?", self[:id], "tool");
  end

  # class Document_Attach < Document
  #   attr_reader :obj

  #   def initialize(obj)
  #       if obj.is_a?(DesignMethod)
  #         super(:content => obj.overview+" "+obj.process)
  #       elsif obj.is_a?(CaseStudy)
  #         super(:content => obj.overview)
  #       end
  #       @obj = obj
  #   end
  # end

  def similar_methods(limit, sample_size)
    # TO_DO implement as non-gsl dependent
    # logger.info "Similar Methods running for: #{self[:name]}"
    # startTime = Time.now

    # methodsList = DesignMethod.where("design_methods.id != ?", self[:id])
    # .order("RANDOM()")
    # .limit(limit)

    # comparator = Corpus.new
    # comparingMethod = Document_Attach.new(self)
    # comparator << comparingMethod

    # methodsList.each do |dm|
    #   comparator << Document_Attach.new(dm)
    # end

    # result = comparator.similar_documents(comparingMethod).sort {|tuple1, tuple2| tuple2[1] <=> tuple1[1] }
    # result = result.map {|tuple| tuple[0].obj}
    # result = result [1..sample_size]

    # endTime = Time.now
    # elapsed_time = endTime - startTime
    # logger.info "Similar Methods took #{elapsed_time}s to query #{limit} random sample from db."
    # return result
    return []
  end

  def similar_case_studies(limit, sample_size)
    # TO_DO implement as non-gsl dependent
    # logger.info "Similar Case Studies running for: #{self[:name]}"
    # startTime = Time.now

    # caseStudiesList = CaseStudy.order("RANDOM()")
    # .limit(limit)

    # comparator = Corpus.new
    # comparingMethod = Document_Attach.new(self)
    # comparator << comparingMethod

    # caseStudiesList.each do |cs|
    #   comparator << Document_Attach.new(cs)
    # end

    # result = comparator.similar_documents(comparingMethod).sort {|tuple1, tuple2| tuple2[1] <=> tuple1[1] }
    # result = result.map {|tuple| tuple[0].obj}
    # result = result [1..sample_size]

    # endTime = Time.now
    # elapsed_time = endTime - startTime
    # logger.info "Similar Case Studies took #{elapsed_time}s to query #{limit} random sample from db."
    # return result
    return []
  end

  def method_categories
    categories = Array.new
    #Currently: inefficient amount of calls b/c most characteristics are in same category

    self.characteristics.each do |c|
      cat = c.characteristic_group.method_category
      if !categories.include?(cat)
        categories << cat
      end
    end

    return categories
  end

end
