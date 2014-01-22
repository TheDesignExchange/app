# == Schema Information
#
# Table name: categorizations
#
#  id                 :integer          not null, primary key
#  design_method_id   :integer
#  method_category_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class CategorizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
