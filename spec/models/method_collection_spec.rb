# == Schema Information
#
# Table name: method_collections
#
#  id               :integer          not null, primary key
#  design_method_id :integer
#  collection_id    :integer
#  created_at       :datetime
#  updated_at       :datetime
#  case_study_id    :integer
#

require 'rails_helper'

RSpec.describe MethodCollection, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
