# == Schema Information
#
# Table name: resources
#
#  id                :integer          not null, primary key
#  name              :string(255)      default("")
#  permission_to_use :boolean          default(FALSE)
#  type              :string(255)      default("")
#  company_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'rails_helper'

RSpec.describe Resource, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
