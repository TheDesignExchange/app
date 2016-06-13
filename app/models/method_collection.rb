class MethodCollection < ActiveRecord::Base
  attr_accessible :design_method_id, :collection_id

  belongs_to :design_method
  belongs_to :collection
  belongs_to :case_study
end
