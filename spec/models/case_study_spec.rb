# == Schema Information
#
# Table name: case_studies
#
#  id                :integer          not null, primary key
#  main_image         :string(255)      default("")
#  title             :string(255)      default("")
#  url               :string(255)      default("")
#  timePeriod        :string(255)      default("")
#  development_cycle :integer
#  design_phase      :integer
#  project_domain    :integer
#  customer_type     :integer
#  user_age          :integer
#  privacy_level     :integer
#  social_setting    :integer
#  overview       :text
#  customerIsUser    :boolean          default(FALSE)
#  remoteProject     :boolean          default(FALSE)
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

require 'rails_helper'

describe CaseStudy do
  let(:company) {FactoryGirl.create(:company)}
  let(:case_study) {FactoryGirl.create(:case_study, company: company)}

  subject { case_study }

  it { should respond_to(:main_image) }
  it { should respond_to(:name) }
  it { should respond_to(:url) }

  it { should respond_to(:timePeriod) }
  it { should respond_to(:development_cycle) }
  it { should respond_to(:design_phase) }

  it { should respond_to(:project_domain) }
  it { should respond_to(:customer_type) }
  it { should respond_to(:user_age) }

  it { should respond_to(:privacy_level) }
  it { should respond_to(:social_setting) }

  it { should respond_to(:overview) }
  it { should respond_to(:customerIsUser) }
  it { should respond_to(:remoteProject) }
  it { should respond_to(:company_id) }

  it { should respond_to(:company) }
  it { should respond_to(:contacts) }
  it { should respond_to(:resources) }

  it { should respond_to(:method_case_studies) }
  it { should respond_to(:design_methods) }

  it { should be_valid }
end
