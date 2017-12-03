class CaseStudiesController < ApplicationController
  load_and_authorize_resource

  before_action :edit_as_signed_in_user, only: [:edit, :update]
  before_action :create_as_signed_in_user, only: [:create, :new]

  def index
    @case_study = CaseStudy.where("overview != ?", "No overview available" )
    # @case_studies = CaseStudy.take(24)
    if params[:sort_order] == "completion"
      @case_studies = CaseStudy.order(completion_score: :desc)
    end

    if params[:filter_category] != nil
      c = CaseStudy.all
      list_of_ids = MethodCategory.find_by(process_order:params[:filter_category]).case_study_ids
      @case_studies = CaseStudy.where(id:list_of_ids)

    end
    @search_filter_hash = MethodCategory.order(:process_order)
    @case_studies_all = CaseStudy.all
    respond_to do |format|
      format.html { render layout: "wide" }
      format.json { render :json => @case_studies_all }
    end
  end

  def new
    @case_study = CaseStudy.new

    @attr = CaseStudy.columns_hash;
    @options = CaseStudy.options
    @helper_text = CaseStudy.helper_text()
    @similar_methods = []
    render :layout => "custom"
  end

  def related_methods
    @case_study = CaseStudy.where("id=?", params[:id]).first;
    @similar_methods = @case_study.similar_methods(DesignMethod.all.length,6)

    respond_to do |format|
      format.html
      format.json { render text: @similar_methods.map{|x| x.name }}
    end
  end

  def clearImage
    @case_study = CaseStudy.find(params[:id])
    @case_study.picture_url = nil
    @case_study.save!
    respond_to do |format|
      format.html { redirect_to @case_study, notice: 'Image was successfully removed.'}
    end
  end

  def edit
    id = params[:id] == nil ? 1 : params[:id].to_i
    # render :text => id
    @cs = CaseStudy.where("id=?", id).first;
    @case_study = CaseStudy.find(params[:id])

    @attr = CaseStudy.columns_hash;
    @methods = @case_study.design_methods().reverse;
    @options = CaseStudy.options
    @helper_text = CaseStudy.helper_text
    @similar_methods = @case_study.similar_methods(100,6)
    render :layout => "custom"
  end

  def show
    require 'dx/props'
    @props = Dx::Props.load_file 'config/props/case_studies.yml'

    id = params[:id].to_i
    @case_study = CaseStudy.find(id)
    @current_author = User.find_by_id(@case_study.author_id)
    @current_editor = User.find_by_id(@case_study.editor_id)
    if !current_user.nil?
      @collections = current_user.owned_collections
      @collection = Collection.new(params[:collection])
      @collection.owner_id = current_user.id
    end

    @similar_methods = @case_study.similar_methods(100,6)
    @similar_case_studies = @case_study.similar_case_studies(100,6)
    @lookup = CaseStudy.lookup
    respond_to do |format|
      format.html { render layout: "custom" }
      format.json { render :json =>  @case_study }
    end
  end

  def search
  end

  def claimAuthor
    @case_study = CaseStudy.find(params[:id])
    @case_study.author_id = current_user.id
    @case_study.save!
    respond_to do |format|
      format.html { redirect_to @case_study, notice: 'Successfully claimed to be author.'}
    end
  end

  def claimEditor
    @case_study = CaseStudy.find(params[:id])
    @case_study.editor_id = current_user.id
    @case_study.save!
    respond_to do |format|
      format.html { redirect_to @case_study, notice: 'Successfully claimed to be editor.'}
    end
  end

  def unclaimAuthor
    @case_study = CaseStudy.find(params[:id])
    @case_study.author_id = nil
    @case_study.save!
    respond_to do |format|
      format.html { redirect_to @case_study, notice: 'Successfully unclaimed to be author.'}
    end
  end

  def unclaimEditor
    @case_study = CaseStudy.find(params[:id])
    @case_study.editor_id = nil
    @case_study.save!
    respond_to do |format|
      format.html { redirect_to @case_study, notice: 'Successfully unclaimed to be editor.'}
    end
  end

  def update
    @case_study = CaseStudy.find(params[:id])
    @case_study.last_editor_id = current_user.id
    @case_study.last_edited = Time.now

    if Rails.env.production?
      file = params[:case_study][:picture]
      @case_study.upload_to_s3(file, request.original_url)
    end

    if params[:commit] == "Save as Draft"
      if @case_study.author_id != nil 
        if (current_user.admin? or current_user.editor?) and current_user != User.find_by(id:@case_study.author_id) and @case_study.ready
            UserMailer.cs_admin_changes_email(User.find_by(id:@case_study.author_id),@case_study).deliver
          end
      end
      @case_study.draft = true
      @case_study.ready = false
      @case_study.last_editor = "#{current_user.first_name} #{current_user.last_name}"
    elsif params[:commit] == "Publish"
      @case_study.draft = false
      @case_study.ready = true
      if @case_study.author_id != nil
        if Rails.env.production?
          if @case_study.author_id != nil
            UserMailer.publication_email(User.find_by(id:@case_study.author_id),@case_study).deliver
          end
        end
      end
      @case_study.last_editor = "#{current_user.first_name} #{current_user.last_name}"
    elsif params[:commit] == "Ready for Approval"
      @case_study.draft = true
      @case_study.ready = true
      if Rails.env.production?
        if @case_study.editor_id != nil
          UserMailer.cs_approval_email(User.find_by(email:"james.jiang@berkeley.edu"), @case_study).deliver
          UserMailer.cs_approval_email(User.find_by_id(@case_study.editor_id), @case_study).deliver
        end
      end
      @case_study.last_editor = "#{current_user.first_name} #{current_user.last_name}"
    end

    respond_to do |format|
      if @case_study.update_attributes(params[:case_study])
        format.html { redirect_to @case_study, notice: 'Case study was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @case_study.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @case_study = CaseStudy.new(params[:case_study])
    @case_study.owner_id = current_user.id
    @case_study.last_editor_id = current_user.id
    @case_study.last_editor = "#{current_user.first_name} #{current_user.last_name}"
    @case_study.last_edited = Time.now

    if Rails.env.production?
      file = params[:case_study][:picture]
      @case_study.upload_to_s3(file, request.original_url)
    end
    
    if params[:commit] == "Save as Draft"
      @case_study.draft = true
      @case_study.ready = false
    elsif params[:commit] == "Publish"
      @case_study.draft = false
      @case_study.ready = true
    elsif params[:commit] == "Ready for Approval"
      @case_study.draft = true
      @case_study.ready = true
      if Rails.env.production?
        if @case_study.editor_id != nil
          UserMailer.cs_approval_email(User.find_by(email:"james.jiang@berkeley.edu"), @case_study).deliver
          UserMailer.cs_approval_email(User.find_by(id:@case_study.editor_id), @case_study).deliver
        end
      end
    end
    
    respond_to do |format|
      #if @design_method.save
      if @case_study.update_attributes(params[:case_study])
        format.html { redirect_to @case_study, notice: 'Case study was successfully created.' }
        format.json { render json: @case_study, status: :created, location: @case_study }
      else
        format.html { render action: "new" }
        format.json { render json: @case_study.errors, status: :unprocessable_entity }
      end
    end
  end

  def filter
  end

  def destroy
    @cs = CaseStudy.find(params[:id])
    @cs.destroy

    respond_to do |format|
      format.html { redirect_to case_studies_path }
      format.json { head :no_content }
    end
  end

  # Confirms a logged-in user.
  def edit_as_signed_in_user
    unless signed_in?
      flash[:danger] = "Please sign in to edit this case study."
      redirect_to case_study_url
    end
  end

  def create_as_signed_in_user
    unless signed_in?
      flash[:danger] = "Please sign in to add a case study."
      redirect_to case_studies_url
    end
  end


end
