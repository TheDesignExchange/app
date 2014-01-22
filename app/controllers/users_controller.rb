class UsersController < ApplicationController

  # Information about the user corresponding to the ID in the URI
  #
  # === Variables
  # - user: the user with the given ID
  # - owned_methods: methods owned by this user
  def show
    @user = User.find(params[:id])
    @owned_methods = @user.owned_methods.limit(10)
    store_location
  end
end
