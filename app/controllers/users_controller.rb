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

  def edit
    @user = User.find(params[:id])
    @owned_methods = @user.owned_methods.limit(12)
    @owned_discussions = @user.owned_discussions.limit(12)
    store_location
    render layout: "wide"
  end

  def create
    @user = DesignMethod.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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

  private

  def user_params
    params.require(:user).permit(
      :username, :email, :encrypted_password, :first_name, :last_name, :profile_picture, :website, :facebook, :twitter, :linkedin, :about_text, :profile_picture
      )
  end

end
