# == Schema Information
#
# Table name: case_studies
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  main_image        :string(255)
#  url               :text
#  overview          :text
#  resource          :text
#  problem           :text
#  process           :text
#  outcome           :text
#  development_cycle :integer
#  design_phase      :integer
#  project_domain    :integer
#  customer_type     :integer
#  user_age          :integer
#  privacy_level     :integer
#  social_setting    :integer
#  customer_is_user  :boolean
#  remote_project    :boolean
#  num_of_designers  :integer
#  num_of_users      :integer
#  time_period       :integer
#  time_unit         :text
#  company_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#  hidden            :boolean

class CaseStudy < ActiveRecord::Base
  mount_uploader :main_image, PictureUploader
  mount_uploader :resource, PictureUploader
  attr_accessible :main_image, :name, :url, :time_period, :development_cycle, :design_phase,
                  :project_domain, :customer_type, :user_age, :privacy_level,
                  :social_setting, :overview, :customer_is_user, :remote_project,
                  :company_id, :num_of_designers, :num_of_users, :overview, :time_period, :time_unit,
                  :resource, :process, :problem, :outcome, :design_method_ids, :hidden,
                  :picture, :picture_url, :completion_score, :draft, :suggestions, :last_editor_id, :tag_ids

  belongs_to :company
  has_many :contacts, :through => :company
  has_many :resources

  # METHOD LINKING
  has_many :method_case_studies
  has_many :design_methods, :through => :method_case_studies
  has_many :tags


  has_many :method_collections, dependent: :destroy
  has_many :collections, through: :method_collections

  # Sunspot
  searchable do
    text :name, stored: true
    text :overview, stored: true
  end

  # validates :development_cycle,
  #    :inclusion  => { :in => ["Product Update", "Product Refinement", "New Product", "Other"],
  #    :message    => "%{value} is not a development cycle" }
  # def contacts
  #     company = Company.where(:case_study_id, self[:id])
  #     company ? company.contacts : nil
  # end

  def tags
      Tag.where("case_study_id = ? and content_type = ?", self[:id], "tag");
  end

  def tools
      Tag.where("case_study_id = ? and content_type = ?", self[:id], "tool");
  end

  def self.options
      select_option = self.lookup
      select_option.each do |name, op|
          collection = []
          op.each_with_index do |choice, i|
              collection << [choice, i]
          end
          select_option[name] = collection
      end
    return select_option
  end

  def self.lookup
      return  {:development_cycle => ["Product Update", "Product Refinement", "New Product", "Other"],
              :design_phase => [ "Problem Assessment", "Conceptual Design", "Detailed Design", "Other"] ,
              :project_domain => ["Built Environment", "Product", "Service", "Web", "Mobile", "Graphic", "Fashion", "Other"],
              :customer_type => ["Government", "Educational Group", "Business", "NGO", "Other"],
              :user_age => ["Child", "Teen", "Young Adult", "Middle Aged", "Elderly" ],
              :privacy_level => ["Private", "Public"],
              :social_setting => ["Personal", "Social", "Professional"]

      }
  end

  def self.helper_text
      return {
          :design_phase => ["The phase involves acquiring or processing information, or defining the problem.", "This phase involves generating or evaluating concepts or prototyping." ,"This phase involves prototyping, manufacturing and deployment."],
          :remote_project => ["remote project = online project"],
          :privacy_level => [" <em> Private </em> means only select few can observe the activity, and effort must be put to respect customs of activity. <span>(Example: religious ceremony)</span>", " <em>Public</em> means activity can be observed by anyone who desires to see the activity."],
          :social_setting => [" <em>Personal</em> includes individual, couple and family.", " <em>Social</em> includes friends, communities (religion, political group) and individual in social context.", " <em>Professional</em> includes work, education, medical and government."]
      }
  end

  def overview
      if self[:overview] == nil
          self[:overview] = "No overview available"
      end
      return self[:overview]
  end

  # class Document_Attach < Document
  #     attr_reader :obj
  #     def initialize(obj)
  #         if obj.is_a?(DesignMethod)
  #           super(:content => obj.overview+" "+obj.process)
  #         elsif obj.is_a?(CaseStudy)
  #           super(:content => obj.overview)
  #         end
  #         @obj = obj
  #     end
  # end

  def similar_methods(limit, sample_size)
    # TO_DO implement as non-gsl dependent
    # logger.info "Similar Methods running for: #{self[:name]}"
    # startTime = Time.now

    # methodsList = DesignMethod.order("RANDOM()")
    # .limit(limit)

    # comparator = Corpus.new

    # query = Document_Attach.new(self)
    # comparator << query

    # methodsList.each do |dm|
    #   comparator << Document_Attach.new(dm)
    # end

    # # debug = []
    # # comparator.similar_documents(comparingCaseStudy).each do |doc, similarity|
    # #     debug << "Similarity between doc #{comparingCaseStudy.id} and doc #{doc.id} is #{similarity}"
    # # end

    # result = comparator.similar_documents(query).sort {|tuple1, tuple2| tuple2[1] <=> tuple1[1] }
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

    # caseStudiesList = CaseStudy.where("case_studies.id != ?", self[:id])
    # .order("RANDOM()")
    # .limit(limit)

    # comparator = Corpus.new
    # comparingCaseStudy = Document_Attach.new(self)
    # comparator << comparingCaseStudy

    # caseStudiesList.each do |cs|
    #   comparator << Document_Attach.new(cs)
    # end

    # result = comparator.similar_documents(comparingCaseStudy).sort {|tuple1, tuple2| tuple2[1] <=> tuple1[1] }
    # result = result.map {|tuple| tuple[0].obj}
    # result = result [1..sample_size]

    # endTime = Time.now
    # elapsed_time = endTime - startTime
    # logger.info "Similar Case Studies took #{elapsed_time}s to query #{limit} random sample from db."
    # return result
    return []
  end

  def upload_to_s3(file, url)
    if !file.nil?
      if url.include? "thedesignexchange-staging"
        path = "staging/case_studies/" + self.id.to_s + "/" + "case-study-" + self.id.to_s
      else
        path = "production/case_studies/" + self.id.to_s + "/" + "case-study-" + self.id.to_s
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
