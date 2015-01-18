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

require 'rails_helper'

RSpec.describe Company, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
