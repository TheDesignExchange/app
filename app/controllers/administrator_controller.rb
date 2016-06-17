class AdministratorController < ApplicationController

  def index
    authorize! :index, :administrator
    @users = User.all
    render layout: "custom"
  end

  def changeAdmin
    authorize! :change_admin, :administrator
    @user = User.find(params[:id])
    @user.roles = [:admin]
    @user.save
    respond_to do |format|
      format.html { redirect_to administrator_path, notice: 'User has now been given admin privileges.'}
      format.json { head :no_content }
    end

  end

  def changeEditor
    authorize! :change_editor, :administrator
    @user = User.find(params[:id])
    @user.roles = [:editor]
    @user.save
    respond_to do |format|
      format.html { redirect_to administrator_path, notice: 'User has now been given editor privileges.'}
      format.json { head :no_content }
    end
  end

  def changeBasic
    authorize! :change_basic, :administrator
    @user = User.find(params[:id])
    @user.roles = [:basic]
    @user.save
    respond_to do |format|
      format.html { redirect_to administrator_path, notice: 'User has now been given basic privileges.'}
      format.json { head :no_content }
    end
  end

end
