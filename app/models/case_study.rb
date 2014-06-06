class CaseStudy < ActiveRecord::Base
	belongs_to :company
	has_many :contacts
	has_many :resources
end
