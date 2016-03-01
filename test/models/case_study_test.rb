# == Schema Information
#
# Table name: case_studies
#
#  id                :integer          not null, primary key
#  main_image        :string(255)      default("")
#  name              :string(255)      default("")
#  url               :string(255)      default("")
#  timePeriod        :string(255)      default("")
#  development_cycle :integer
#  design_phase      :integer
#  project_domain    :integer
#  customer_type     :integer
#  user_age          :integer
#  privacy_level     :integer
#  social_setting    :integer
#  overview          :text
#  customer_is_user  :boolean          default(FALSE)
#  remote_project    :boolean          default(FALSE)
#  company_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#  num_of_designers  :integer          default(1)
#  num_of_users      :integer          default(1)
#  time_period       :integer          default(0)
#  time_unit         :string(255)      default("")
#  resource          :string(255)
#  problem           :text
#  process           :text
#  outcome           :text
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
