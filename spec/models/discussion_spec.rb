require 'rails_helper'

describe Discussion do
  let(:user) { FactoryGirl.create(:user) }
  let(:discussion) { FactoryGirl.create(:discussion, user: user) }

  subject { discussion }

  it { should respond_to :title }
  it { should respond_to :description }
  it { should respond_to :user }
  it { should respond_to :replies }

  it { should be_valid }

end
