class AdministratorController < ApplicationController

  def index
    authorize! :index, :administrator
    if (current_user == nil) || (!current_user.admin?)
      redirect_to root_path
    else
      @users = User.all
      @characteristics = Characteristic.all
      @design_methods = DesignMethod.all
      @case_studies = CaseStudy.all
      render layout: "custom"
    end
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

  def changeAuthor
    authorize! :change_author, :administrator
    @user = User.find(params[:id])
    @user.roles = [:author]
    @user.save
    respond_to do |format|
      format.html { redirect_to administrator_path, notice: 'User has now been given author privileges.'}
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
