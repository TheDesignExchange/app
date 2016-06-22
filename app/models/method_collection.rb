# == Schema Information
#
# Table name: method_collections
#
#  id                 :integer          not null, primary key
#  created_at         :datetime
#  updated_at         :datetime
#  design_method_id
#  case_study_id
#  collection_id
#

class MethodCollection < ActiveRecord::Base
  attr_accessible :design_method_id, :collection_id, :case_study_id

  belongs_to :design_method
  belongs_to :collection
  belongs_to :case_study
end
