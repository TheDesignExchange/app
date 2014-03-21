class MethodFavorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :design_method
end
