# == Schema Information
#
# Table name: user_methods
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  design_method_id :integer          not null
#  type_id          :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class UserMethod < ActiveRecord::Base
  after_create :default_type_owned


end
