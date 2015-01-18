# == Schema Information
#
# Table name: design_methods
#
#  id               :integer          not null, primary key
#  name             :string(255)      not null
#  overview         :text             not null
#  process          :text             not null
#  owner_id         :integer          not null
#  parent_id        :integer
#  created_at       :datetime
#  updated_at       :datetime
#  num_of_designers :integer          default(1)
#  num_of_users     :integer          default(1)
#  time_period      :integer          default(0)
#  time_unit        :string(255)      default("")
#  main_image       :string(255)
#  likes            :integer          default(0)
#  aka              :string(255)
#

require 'test_helper'

class DesignMethodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
