# == Schema Information
#
# Table name: citations
#
#  id         :integer          not null, primary key
#  text       :text
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Citation do
  # TODO: add relationship tests
  let(:citation) { FactoryGirl.create(:citation) }

  subject { citation }

  it { should respond_to(:text) }

  it { should respond_to(:method_citations) }
  it { should respond_to(:design_methods) }

  it { should be_valid }

  describe "when text is not present" do
    before { citation.text = "" }
    it { should_not be_valid }
  end
end
