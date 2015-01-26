# == Schema Information
#
# Table name: method_variations
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  variant_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe MethodVariation, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
