# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)      default("")
#  email      :string(255)      default("")
#  phone      :string(255)      default("")
#  company_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
	has_many :case_studies
	validates_uniqueness_of :name, :email
end
