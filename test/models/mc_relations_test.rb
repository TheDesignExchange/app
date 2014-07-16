# == Schema Information
#
# Table name: mc_relations
#
#  id          :integer          not null, primary key
#  parent_id   :integer
#  child_id    :integer
#  distance    :integer
#  description :string(255)      default("subclass")
#  created_at  :datetime
#  updated_at  :datetime
#

require 'test_helper'

class McRelationsTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
