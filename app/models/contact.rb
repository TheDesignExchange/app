class Contact < ActiveRecord::Base
	attr_accessible :name, :email, :phone, :company_id
	has_many :case_studies
	belongs_to :company
	validates_presence_of :name, :email

	before_save { self.email = email.downcase }
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

end
