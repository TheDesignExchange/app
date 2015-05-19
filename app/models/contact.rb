# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  phone      :string(255)
#  company_id :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
	attr_accessible :name, :email, :phone, :company_id
	has_many :case_studies
	belongs_to :company
	validates_presence_of :name
  validates_presence_of :email 

	before_save { self.email = email.downcase }
  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email,
  									presence:   true, 
  									format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

end
