# == Schema Information
#
# Table name: method_characteristics
#
#  id                :integer          not null, primary key
#  design_method_id  :integer
#  characteristic_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

require 'rails_helper'

RSpec.describe MethodCharacteristic, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
