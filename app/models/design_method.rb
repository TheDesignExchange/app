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
#  online_resources   :text
#  history            :text
#  critiques          :text
#  additional_reading :text
#  videoURL           :string(255)
#  collection_id      :integer
#  references         :text
#  characteristic_ids
#  videoURL           :text
#  hidden             :boolean

class DesignMethod < ActiveRecord::Base

  # TODO: add the mass assignment protection at the controller, then remove this
  attr_accessible :name, :process, :num_of_designers, :num_of_users, :overview,
                  :main_image, :time_period, :name, :time_unit, :synonyms, :benefits,
                  :limitations, :skills, :usage, :online_resources, :history, :critiques,
                  :additional_reading, :characteristic_ids, :references, :case_study_ids,
                  :videoURL, :hidden, :picture, :picture_url

  # Validations
  validates :name, :overview, presence: true
  validates :name, length: { maximum: 255,
            too_long: "%{count} is the maximum character length."}
  validates :name, uniqueness: { case_sensitive: false,
            message: "Already exists. Try editing an existing one."},
            on: :create,
            presence: true
  validates :owner_id, presence: true
  validates :process, presence: true

  validates :overview, presence: true

  validates_format_of :videoURL, :with => /https:\/\/www\.youtube\.com\/embed\/([a-zA-Z0-9_-]*)/, allow_blank: true


  # Relationships
  has_many :method_characteristics, dependent: :destroy
  has_many :characteristics, through: :method_characteristics
  has_many :characteristic_groups, -> { uniq }, through: :characteristics
  has_many :method_categories, -> { uniq }, through: :characteristic_groups

  has_many :method_citations, dependent: :destroy
  has_many :citations, through: :method_citations

  has_many :method_favorites, dependent: :destroy
  has_many :favorited_users, through: :method_favorites, :source => :user

  has_many :method_collections, dependent: :destroy
  has_many :collections, through: :method_collections

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

    integer :characteristic_ids, :multiple => true
    integer :method_category_ids, :multiple => true
  end

  def overview
    if self[:overview] == "default"
      self[:overview] = "No overview available"
    end
    return self[:overview]
  end

  def process
    if self[:process] == "default"
      self[:process] = "No instructions available"
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

  def update_citations
    # Add Method references as citations
    citations = self.citations
    references = self.references
    if !references.nil?
      citations.each do |c|
        if !references.include? c.text
          c.destroy
        end
      end
    else
      references = ""
      citations.each do |c|
        if !references.include? c.text
          references += c.text + "\n"
        end
      end
    end
    if !references.blank?
      urls = references.split("\n")
      urls.each do |url|
        if !url.blank?
          contains = false
          citations.each do |c|
            if c.text.strip == url.strip
              contains = true
            end
          end
          if !contains
            citation = Citation.new(text: url.strip)
            citation.save
            citations.push(citation)
          end
        end
      end
    end
    self.save
  end


  def upload_to_s3(file, url)
    if !file.nil?
      if url.include? "thedesignexchange-staging"
        path = "staging/design_methods/" + self.id.to_s + "/" + "design-method-" + self.id.to_s
      else
        path = "production/design_methods/" + self.id.to_s + "/" + "design-method-" + self.id.to_s
      end
      obj = S3_BUCKET.object(path)
      obj.upload_file(file.path, acl:'public-read')
      self.update(picture_url: obj.public_url)
    end
  end

  def has_image?
    if Rails.env.production?
      return self.picture_url.present?
    else
      return self.main_image.url.present?
    end
  end

  def image_url
    if Rails.env.production?
      return self.picture_url
    else
      return self.main_image
    end
  end

end
