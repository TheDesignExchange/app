class Contact < ActiveRecord::Base
	has_many :case_studies
	validate_uniqueness_of :name, :email
end
