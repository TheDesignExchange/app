class AdministratorController < ApplicationController

  def new
  end

  def tabledemo
  end

  def index
    authorize! :index, :administrator
    @users = User.all
    #@users = User.paginate(:page => params[:page], :per_page => 4)
    @usersAdmin = User.paginate(:page => params[:admin_page], :per_page => 4)
    @usersEditor = User.paginate(:page => params[:editor_page], :per_page => 4)
    @usersBasic = User.paginate(:page => params[:basic], :per_page => 4)
    @characteristics = Characteristic.all
    #@characteristics = Characteristic.paginate(:page => params[:characteristics_page], :per_page => 12)

    @CharacteristicGroups = CharacteristicGroup.paginate(:page => params[:char_groups_page], :per_page => 12)
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

  def sort
    authorize! :sort, :administrator
    #name alphabetical
    if params[:sort] == "name"
      @users = User.order(username: :asc).paginate(:page => params[:page], :per_page => 4)
      @usersAdmin = User.order(username: :asc).paginate(:page => params[:admin_page], :per_page => 4)
      @usersEditor = User.order(username: :asc).paginate(:page => params[:editor_page], :per_page => 4)
      @usersBasic = User.order(username: :asc).paginate(:page => params[:basic], :per_page => 4)
    end
    #Username alphabetical
    if params[:sort] == "username"
      @users = User.order(last_name: :asc).paginate(:page => params[:page], :per_page => 4)
      @usersAdmin = User.order(last_name: :asc).paginate(:page => params[:admin_page], :per_page => 4)
      @usersEditor = User.order(last_name: :asc).paginate(:page => params[:editor_page], :per_page => 4)
      @usersBasic = User.order(last_name: :asc).paginate(:page => params[:basic], :per_page => 4)
    end
    #Email
    if params[:sort] == "email"
      @users = User.order(email: :asc).paginate(:page => params[:page], :per_page => 4)
      @usersAdmin = User.order(email: :asc).paginate(:page => params[:admin_page], :per_page => 4)
      @usersEditor = User.order(email: :asc).paginate(:page => params[:editor_page], :per_page => 4)
      @usersBasic = User.order(email: :asc).paginate(:page => params[:basic], :per_page => 4)
    end
    #Date
    if params[:sort] == "date"
      @users = User.order(created_at: :asc).paginate(:page => params[:page], :per_page => 4)
      @usersAdmin = User.order(created_at: :asc).paginate(:page => params[:admin_page], :per_page => 4)
      @usersEditor = User.order(created_at: :asc).paginate(:page => params[:editor_page], :per_page => 4)
      @usersBasic = User.order(created_at: :asc).paginate(:page => params[:basic], :per_page => 4)
    end

    @characteristics = Characteristic.paginate(:page => params[:characteristics_page], :per_page => 12)
    @CharacteristicGroups = CharacteristicGroup.paginate(:page => params[:char_groups_page], :per_page => 12)
    render :layout => 'custom', :action => 'index'

  end

  def changeName
  end
end
