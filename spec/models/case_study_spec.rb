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

require 'rails_helper'

describe CaseStudy do
  let(:company) {FactoryGirl.create(:company)}
  let(:case_study) {FactoryGirl.create(:case_study, company: company)}

  subject { case_study }

  it { should respond_to(:main_image) }
  it { should respond_to(:name) }
  it { should respond_to(:url) }

  it { should respond_to(:time_period) }
  it { should respond_to(:development_cycle) }
  it { should respond_to(:design_phase) }

  it { should respond_to(:project_domain) }
  it { should respond_to(:customer_type) }
  it { should respond_to(:user_age) }

  it { should respond_to(:privacy_level) }
  it { should respond_to(:social_setting) }

  it { should respond_to(:overview) }
  it { should respond_to(:customer_is_user) }
  it { should respond_to(:remote_project) }
  it { should respond_to(:company_id) }

  it { should respond_to(:company) }
  it { should respond_to(:contacts) }
  it { should respond_to(:resources) }

  it { should respond_to(:method_case_studies) }
  it { should respond_to(:design_methods) }

  it { should be_valid }
end
