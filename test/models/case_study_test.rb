# == Schema Information
#
# Table name: case_studies
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  main_image        :string(255)
#  url               :text
#  overview          :text
#  resource          :text
#  problem           :text
#  process           :text
#  outcome           :text
#  development_cycle :integer
#  design_phase      :integer
#  project_domain    :integer
#  customer_type     :integer
#  user_age          :integer
#  privacy_level     :integer
#  social_setting    :integer
#  customer_is_user  :boolean
#  remote_project    :boolean
#  num_of_designers  :integer
#  num_of_users      :integer
#  time_period       :integer
#  time_unit         :text
#  company_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'test_helper'

class CaseStudyTest < ActiveSupport::TestCase 
  setup do 
    @case_study = case_studies(:iWitness)
  end 

  test "should be valid" do
    assert @case_study.valid?
  end
end 
