# == Schema Information
#
# Table name: design_methods
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  overview   :text             not null
#  process    :text             not null
#  principle  :text             not null
#  owner_id   :integer          not null
#  parent_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class DesignMethodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
