class UsersController < ApplicationController

  # Information about the user corresponding to the ID in the URI
  #
  # === Variables
  # - user: the user with the given ID
  # - owned_methods: methods owned by this user
  def show
    @user = User.find(params[:id])
    @owned_methods = @user.owned_methods.limit(12)
    @owned_discussions = @user.owned_discussions.limit(12)
    if user_signed_in?
      @is_current_user = @user.id == current_user.id
    else
      @is_current_user = false
    end
    store_location
    render layout: "wide"
  end

end
