class DesignMethodsController < ApplicationController

  def index
    @design_methods = DesignMethod.where("overview != ?", "No overview available" ).take(24)
    render :layout => "wide"
  end

  def new
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
    @design_method = DesignMethod.new(design_method_params)
    @design_method.owner = current_user

    respond_to do |format|
      if @design_method.save
        format.html { redirect_to @design_method, notice: 'Design method was successfully created.' }
        format.json { render json: @design_method, status: :created, location: @design_method }
      else
        format.html { render action: "new" }
        format.json { render json: @design_method.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    id = params[:id].to_i
    #default to method id #1 TODO remove
    dm = DesignMethod.find(id)
    @method = dm
    @author = dm.owner
    @citations = dm.citations
    @similar_methods = @method.similar_methods(100,6)
    @similar_case_studies = @method.similar_case_studies(100,6)
    render :layout => "custom"
    # render :json => @method.neighbors(100, 6)
  end

  def search
    render :layout => "wide"
  end
end
