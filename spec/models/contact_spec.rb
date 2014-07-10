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

require 'rails_helper'

RSpec.describe Contact, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
