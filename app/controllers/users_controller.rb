class UsersController < ApplicationController
  load_and_authorize_resource

  # Information about the user corresponding to the ID in the URI
  #
  # === Variables
  # - user: the user with the given ID
  # - owned_methods: methods owned by this user

  def show
    @user = User.find(params[:id])
    @owned_methods = @user.owned_methods.limit(12)
    @owned_discussions = @user.owned_discussions.limit(12)
    @owned_collections = @user.owned_collections

    @private_collections = @owned_collections.where(is_private: true)
    @public_collections = @owned_collections.where(is_private: false)

    @private_collections = @private_collections.paginate(page: params[:private_page], :per_page => 10)
    @public_collections = @public_collections.paginate(page: params[:public_page], :per_page => 10)
    if user_signed_in?
      @is_current_user = @user.id == current_user.id
    else                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
      @is_current_user = false
    end
    store_location
    render layout: "custom"
  end

  def edit
    @user = User.find(params[:id])
    @owned_methods = @user.owned_methods.limit(12)
    @owned_discussions = @user.owned_discussions.limit(12)
    @owned_collections = @user.owned_collections
    @private_collections = @owned_collections.where(is_private: true)
    @public_collections = @owned_collections.where(is_private: false)
    store_location
    render layout: "wide"
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload
    uploaded_io = params[:user][:profile_picture]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
  end

  def user_params
    params.require(:user).permit(
      :username, :email, :encrypted_password, :first_name, :last_name, :profile_picture, :website, :facebook, :twitter, :linkedin, :about_text, :profile_picture, :zip_code, :affiliation, :member_type
      )
  end



end
