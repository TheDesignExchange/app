require 'dx/props'
require "uri"

class DesignMethodsController < ApplicationController
  load_and_authorize_resource

  before_action :edit_as_signed_in_user, only: [:edit, :update]
  before_action :create_as_signed_in_user, only: [:create, :new]

  layout 'custom'

  def index
      @design_methods = DesignMethod.where("overview != ?", "No overview available" )
      # .take(24)
      # @design_methods = DesignMethod.take(24)
       # Filter bar needs
      @search_filter_hash = MethodCategory.all
      @design_methods_all = DesignMethod.all
      respond_to do |format|
        format.html { render :layout => "wide" }
        format.json { render json: @design_methods_all}
      end
  end

  def new
    @design_method = DesignMethod.new
    render :layout => "custom"
  end

  # Edit an existing DesignMethod
  #
  # === Parameters
  # - id: ID of the design method to be edited
  #
  # === Variables
  # - @design_method: the design method to be edited
  def edit
    @design_method = DesignMethod.find(params[:id])
    render :layout => "custom"
  end


  # Update an existing DesignMethod corresponding to the ID in the URI
  #
  # === Request Body
  # - design_method: a hash containing information to update the DesignMethod with
  #
  # === Variables
  # - @design_method: the updated design method
  def update
    @design_method = DesignMethod.find(params[:id])

    #obj = S3_BUCKET.objects[params[:main_image].original_filename]
    # Upload the file
    #obj.write(
      #file: params[:main_image],
      #acl: :public_read
    #)

    # Create an object for the upload
    #@upload = Upload.new(
      #url: obj.public_url,
      #name: obj.key
    #)
    puts "FILE UPLOAD HERE!!!!"
    puts params[:design_method][:picture].path()
    S3_BUCKET.object(params[:design_method][:picture].original_filename).upload_file(params[:design_method][:picture].original_filename, acl:'public-read')

    respond_to do |format|
      if @design_method.update_attributes(params[:design_method]) && @upload.save
        @design_method.update_citations
        format.html { redirect_to @design_method, notice: 'Design method was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @design_method.errors, status: :unprocessable_entity }
      end
    end
  end


  # Creates a DesignMethod
  #
  # === Request Body
  # - design_method: a hash containing the required fields for creating a DesignMethod
  #
  # === Variables
  # - @design_method: the newly created design method
  def create
    @design_method = DesignMethod.new(params[:design_method])
    @design_method.owner = current_user

    obj = S3_BUCKET.objects[params[:main_image].original_filename]
    # Upload the file
    obj.write(
      file: params[:main_image],
      acl: :public_read
    )

    # Create an object for the upload
    @upload = Upload.new(
      url: obj.public_url,
      name: obj.key
    )

    # @design_method.principle = ""

    respond_to do |format|
      if @design_method.save && @upload.save
        @design_method.update_citations
        format.html { redirect_to @design_method, notice: 'Design method was successfully created.' }
        format.json { render json: @design_method, status: :created, location: @design_method }
      else
        format.html { render action: "new" }
        format.json { render json: @design_method.errors, status: :unprocessable_entity }
      end
    end
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
    @method.save

    @similar_methods = @method.similar_methods(100,6)
    @similar_case_studies = @method.similar_case_studies(100,6)
    respond_to do |format|
      format.html { render :layout => "custom" }
      format.json {render :json => @method}
    end
  end

  def search
    render :layout => "wide"
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

end
