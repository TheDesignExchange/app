# == Schema Information
#
# Table name: resources
#
#  id                :integer          not null, primary key
#  name              :string(255)      default("")
#  permission_to_use :boolean          default(FALSE)
#  type              :string(255)      default("")
#  company_id        :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'rails_helper'

describe Resource do
  let(:resource) {FactoryGirl.create(:resource)}

  subject { resource }

  it { should respond_to(:name) }
  it { should respond_to(:permission_to_use) }
  it { should respond_to(:type) }
  it { should respond_to(:company_id) }

  it { should be_valid }
end
