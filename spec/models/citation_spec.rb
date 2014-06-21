# == Schema Information
#
# Table name: citations
#
#  id         :integer          not null, primary key
#  text       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Citation do
  # TODO: add relationship tests
  let(:citation) { FactoryGirl.create(:citation) }

  subject { citation }

  it { should respond_to(:text) }

  describe "when text is not present" do
    before { citation.text = "" }
    it { should_not be_valid }
  end
end
