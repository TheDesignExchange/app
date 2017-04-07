require 'dx/props'
require "uri"

class DesignMethodsController < ApplicationController
  load_and_authorize_resource

  before_action :edit_as_signed_in_user, only: [:edit, :update]
  before_action :create_as_signed_in_user, only: [:create, :new]

  layout 'custom'

  def index
      @design_methods = DesignMethod.order(completion_score: :desc)
      if params[:sort_order] == "completion"
        @design_methods = DesignMethod.order(completion_score: :desc)
      end
      list_of_ids = []
      if params[:characteristic] != nil || params[:characteristic_group] != nil
        characteristics = params[:characteristic].to_s.split("/s")
        for characteristic in characteristics
          if characteristic != ""
            list_of_ids += Characteristic.find_by(name:characteristic).design_method_ids
          end
        end
        characteristic_groups = params[:characteristic_group].to_s.split("/s")
        for characteristic_group in characteristic_groups
          if characteristic_group != ""
            list_of_ids += CharacteristicGroup.find_by(name:characteristic_group).design_method_ids
          end
        end
        @design_methods = DesignMethod.where(id: list_of_ids)
      end
      if params[:filter_category] != nil
        categories = params[:filter_category].to_s.split("/s")
        for category in categories
          if category != ""
            list_of_ids = MethodCategory.find_by(name:category).design_method_ids
          end
        end
        @design_methods = DesignMethod.where(id:list_of_ids)
      end

      # if params[:characteristic_group] != nil
      #   characteristic_groups = params[:characteristic_group].split("/s")
      #   for characteristic_group in characteristic_groups
      #    if characteristic_group != ""
      #       list_of_ids += CharacteristicGroup.find_by(name:characteristic_group).design_method_ids
      #     end
      #   end
      #   @design_methods = DesignMethod.where(id: list_of_ids)
      # end

      # Filter bar needs
      @search_filter_hash = MethodCategory.order(:process_order)
      @design_methods_all = DesignMethod.all
      respond_to do |format|
        format.html { render :layout => "wide" }
        format.json { render json: @design_methods_all}
      end
  end


  def new
    @new = true
    @design_method = DesignMethod.new
    render :layout => "custom"
  end

  def edit
    @design_method = DesignMethod.find(params[:id])
    render :layout => "custom"
  end

  def update
    @design_method = DesignMethod.find(params[:id])
    @design_method.last_editor_id = current_user.id
    @design_method.last_editor = "#{current_user.first_name} #{current_user.last_name}"
    @design_method.last_edited = Time.now

    if !(current_user.admin? || current_user.editor? || current_user.author?)
      @design_method.hidden = true
    end

    if params[:commit] == "Save as Draft"
      if Rails.env.production?
        if @design_method.author_id != nil
          if (current_user.admin? or current_user.editor?) and current_user.id != @design_method.author_id and @design_method.ready 
            UserMailer.admin_changes_email(User.find_by(id:@design_method.author_id),@design_method).deliver
          end
        end
      end
      @design_method.draft = true
      @design_method.ready = false

    elsif params[:commit] == "Publish"
      @design_method.draft = false
      @design_method.ready = true
      if Rails.env.production?
        if @design_method.author_id != nil
          UserMailer.publication_email(User.find_by(id:@design_method.author_id), @design_method).deliver
        end
      end

    elsif params[:commit] == "Ready for Approval"
      @design_method.draft = true
      @design_method.ready = true
      if Rails.env.production?
        if @design_method.editor_id != nil
          UserMailer.approval_email(User.find_by(email:"james.jiang@berkeley.edu"), @design_method).deliver
          UserMailer.approval_email(User.find_by(id:@design_method.editor_id), @design_method).deliver
        end
      end
    end

    if Rails.env.production?
      file = params[:design_method][:picture]
      @design_method.upload_to_s3(file, request.original_url)
    end

    respond_to do |format|
      if @design_method.update_attributes(params[:design_method])
        @design_method.update_citations
        format.html { redirect_to @design_method, notice: 'Design method was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @design_method.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @design_method = DesignMethod.new(params[:design_method])
    @design_method.owner = current_user
    @design_method.last_editor_id = current_user.id
    @design_method.last_editor = "#{current_user.first_name} #{current_user.last_name}"
    @design_method.last_edited = Time.now
    
    if !(current_user.admin? || current_user.editor? || current_user.author?)
      @design_method.hidden = true
    end

    if params[:commit] == "Save as Draft"
      @design_method.draft = true
      @design_method.ready = false
    elsif params[:commit] == "Publish"
      @design_method.draft = false
      @design_method.ready = true
    elsif params[:commit] == "Ready for Approval"
      @design_method.draft = true
      @design_method.ready = true
      if Rails.env.production?
        if @design_method.editor_id != nil
          UserMailer.approval_email(User.find_by(email:"james.jiang@berkeley.edu"), @design_method).deliver
          UserMailer.approval_email(User.find_by(id: @design_method.editor_id), @design_method).deliver
        end
      end
    end

    if Rails.env.production?
      file = params[:design_method][:picture]
      @design_method.upload_to_s3(file, request.original_url)
    end

    respond_to do |format|
      if @design_method.update_attributes(params[:design_method])
        @design_method.update_citations
        format.html { redirect_to @design_method, notice: 'Design method was successfully created.' }
        format.json { render json: @design_method, status: :created, location: @design_method }
      else
        format.html { render action: "new" }
        format.json { render json: @design_method.errors, status: :unprocessable_entity }
      end
    end
  end

  def popular

  end

  def show
    require 'dx/props'
    @props = Dx::Props.load_file 'config/props/design_methods.yml'

    id = params[:id].to_i
    #default to method id #1 TODO remove
    dm = DesignMethod.find(id)
    @method = dm
    if !current_user.nil?
      @collections = current_user.owned_collections
      @collection = Collection.new(params[:collection])
      @collection.owner_id = current_user.id
    end
    # Method likes:
    @method.likes += 1
    @method.save!
    # Method likes end.

    @citations = dm.citations
    @author = dm.owner
    @current_author = User.find_by_id(dm.author_id)
    @current_editor = User.find_by_id(dm.editor_id)
    @method.save

    @similar_methods = @method.similar_methods(100,6)
    @similar_case_studies = @method.similar_case_studies(100,6)
    respond_to do |format|
      format.html { render :layout => "custom" }
      format.json {render :json => @method}
    end
  end

  def share
    @design_method = DesignMethod.find(params[:id])
  end

  def clearImage
    @design_method = DesignMethod.find(params[:id])
    @design_method.picture_url = nil
    @design_method.save!
    respond_to do |format|
      format.html { redirect_to @design_method, notice: 'Image was successfully removed.'}
    end
  end

  def claimAuthor
    @design_method = DesignMethod.find(params[:id])
    @design_method.author_id = current_user.id
    @design_method.save!
    respond_to do |format|
      format.html { redirect_to @design_method, notice: 'Successfully claimed to be author.'}
    end
  end

  def claimEditor
    @design_method = DesignMethod.find(params[:id])
    @design_method.editor_id = current_user.id
    @design_method.save!
    respond_to do |format|
      format.html { redirect_to @design_method, notice: 'Successfully claimed to be editor.'}
    end
  end

  def unclaimAuthor
    # An author and editor, should be able to unclaim a method or case study after they claim it.
    @design_method = DesignMethod.find(params[:id])
    @design_method.author_id = nil
    @design_method.save!
    respond_to do |format|
      format.html { redirect_to @design_method, notice: 'Successfully unclaimed to be author.'}
    end
  end

  def unclaimEditor
    # Once editor can unclaim
    @design_method = DesignMethod.find(params[:id])
    @design_method.editor_id = nil
    @design_method.save!
    respond_to do |format|
      format.html { redirect_to @design_method, notice: 'Successfully unclaimed to be editor.'}
    end
  end

  def shareMethod
    @design_method = DesignMethod.find(params[:id])
    @email_of_friend = params[:email_of_friend]
    if Rails.env.production?
      UserMailer.share_method_email(@email_of_friend, current_user, @design_method).deliver
    end
    respond_to do |format|
      format.html { redirect_to @design_method, notice: "Successfully shared method"}
    end
  end

  # Confirms that user is logged-in.
  def edit_as_signed_in_user
    unless signed_in?
      flash[:danger] = "Please sign in to edit this design method."
      redirect_to design_method_url
    end
  end


  def create_as_signed_in_user
    unless signed_in?
      flash[:danger] = "Please sign in to add a design method."
      redirect_to design_methods_url
    end
  end



  def destroy
    @design_method = DesignMethod.find(params[:id])
    DesignMethod.delete(@design_method)
    respond_to do |format|
        format.html { redirect_to '/design_methods', notice: 'Design method was successfully deleted.' }
    end
  end
end
