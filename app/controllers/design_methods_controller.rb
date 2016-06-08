require 'dx/props'
require "uri"

class DesignMethodsController < ApplicationController
  before_action :edit_as_signed_in_user, only: [:edit, :update]
  before_action :create_as_signed_in_user, only: [:create, :new]

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
    respond_to do |format|
      if @design_method.update_attributes(params[:design_method])
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
    # @design_method.principle = ""

    respond_to do |format|
      if @design_method.save
        @citations
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

    # Method likes:
    @method.likes += 1
    @method.save!
    # Method likes end.

    if @method.references == nil
      @method.references = ""
    end

    # Add Method references as citations
    if !@method.references.blank?
      urls = @method.references.split("\n")
      urls.each do |url|
        if url.blank?
          next
        end
        citation = Citation.new(text: url)
        citation.save
        contains = false
        dm.citations.each do |c|
          if c.text.strip == url.strip
            contains = true
          end
        end
        if !contains
          dm.citations.push(citation)
        end
      end
    end

    @author = dm.owner
    @citations = dm.citations

    @citations.each do |cit|
      if @method.references.include? cit.text
        next
      end
      @method.references += cit.text + "\n"
      @method.save
    end

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
