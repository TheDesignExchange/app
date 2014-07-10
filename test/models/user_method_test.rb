# == Schema Information
#
# Table name: user_methods
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  design_method_id :integer          not null
#  type_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

require 'test_helper'

class UserMethodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
