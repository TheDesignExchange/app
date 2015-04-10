# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  domain     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Company < ActiveRecord::Base
	attr_accessible :name, :email, :domain, :id
	before_save { self.email = email.downcase }
  	# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	# validates :email, 
  	# 								presence:   true,
   #                  format:     { with: VALID_EMAIL_REGEX },
   #                  uniqueness: { case_sensitive: false }

	has_many :case_studies
	has_many :contacts

	#validates :name, uniqueness: true
	#validates_presence_of :name, :domain, :email
end
