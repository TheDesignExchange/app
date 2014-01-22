class UserMethod < ActiveRecord::Base
  after_create :default_type_owned


end
