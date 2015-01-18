# == Schema Information
#
# Table name: tags
#
#  id               :integer          not null, primary key
#  design_method_id :integer
#  case_study_id    :integer
#  discussion_id    :integer
#  user_id          :integer
#  content          :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  content_type     :string(255)      default("tag")
#

require 'rails_helper'

RSpec.describe Tag, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
