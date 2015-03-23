# == Schema Information
#
# Table name: method_case_studies
#
#  id               :integer          not null, primary key
#  case_study_id    :integer
#  design_method_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

require 'rails_helper'

RSpec.describe MethodCaseStudy, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
