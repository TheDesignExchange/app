# == Schema Information
#
# Table name: design_methods
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  overview   :text
#  process    :text
#  principle  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class DesignMethodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
