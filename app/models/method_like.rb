# == Schema Information
#
# Table name: method_likes
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  design_method_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class MethodLike < ActiveRecord::Base
end
