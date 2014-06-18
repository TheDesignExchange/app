class Company < ActiveRecord::Base
	has_many :case_studies
	has_many :contacts

	validates_uniqueness_of :name
end
