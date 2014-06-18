class Contact < ActiveRecord::Base
	has_many :case_studies
	validates_uniqueness_of :name, :email
end
