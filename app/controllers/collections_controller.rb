class CollectionsController < ApplicationController
  load_and_authorize_resource
  def index
    @collections = Collection.all
    @public_collections = Collection.where(is_private: false) 
    @public_collections = @public_collections.paginate(page: params[:public_page], :per_page => 10)

    if !current_user.nil?
      @owned_collections = current_user.owned_collections
      @private_collections = @owned_collections.where(is_private: true)
      @private_collections = @private_collections.paginate(page: params[:private_page], :per_page => 10)
    end
    render :layout => "custom"
  end

  def new
    if !current_user.nil?
      @collection = Collection.new
      render :layout => "custom"
    else
      redirect_to({ action: "index" }, :flash => { :warning => "You must be logged in to create a collection." })
    end
  end

  def create
    @collection = Collection.new(params[:collection])

    ids = params[:collection]
    if ids.key?("method_id")
      method_id = ids[:method_id]
      @method = DesignMethod.find(method_id)
      @collection.design_methods.push(@method)
    end
    if ids.key?("cs_id")
      cs_id = ids[:cs_id]
      @case_study = CaseStudy.find(cs_id)
      @collection.case_studies.push(@case_study)
    end

    respond_to do |format|
      @collection.update_attribute(:name, params[:collection][:name])
      @collection.update_attribute(:owner_id, current_user.id)
      if @collection.save
        if request.referrer.include? "collections/new"
          format.html { redirect_to({:action => :index}, {:notice => "Collection was successfully created."}) }
        else
          format.html { redirect_to :back, notice: 'Collection was successfully created.'}
          format.json { render json: @collection, status: :created, location: @collection }
        end
      else
        @collection.destroy
        format.html { redirect_to :back, :flash => { :warning => "New Collection must have a name." } }
      end
    end
  end

  def show
    id = params[:id].to_i
    @user = current_user
    @collection = Collection.find(id)
    @author = @collection.owner
    render :layout => "custom"
  end

  # Adds a design method or case study to an existing collection
  #
  # === Parameters
  # - id: ID of the collection to be edited
  #
  # === Variables
  # - @collection: the collection to be edited
  # - @method: the method to be added
  # - @case_study: the case study to be added

  def add
    @collection = Collection.find(params[:col_id])

    if params.has_key?(:method_id)
      @method = DesignMethod.find(params[:method_id])
      @collection.design_methods.push(@method)
    end
    if params.has_key?(:cs_id)
      @case_study = CaseStudy.find(params[:cs_id])
      @collection.case_studies.push(@case_study)
    end

    respond_to do |format|
      if @collection.save
        format.html { redirect_to :back, notice: 'Successfully added to Collection.'}
        format.json { render json: @collection, status: :created, location: @collection }
      else
        format.html { redirect_to :back, :flash => { :warning => "Not added to Collection due to errors." } }
        format.json { render json: @collection, status: :created, location: @collection }
      end
    end
  end

  def edit
    @collection = Collection.find(params[:id])
    if current_user.id == @collection.owner_id
      render :layout => "custom"
    else
      redirect_to :back, :flash => { :warning => "Collections can only be edited by the user that created them." }
    end
  end

  def update
    @collection = Collection.find(params[:id])
    respond_to do |format|
      if @collection.update_attributes(params[:collection])
        format.html { redirect_to @collection, notice: 'Collection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # Deletes existing collection
  #
  # === Parameters
  # - id: ID of the collection to be deleted
  #
  # === Variables
  # - @collection: the collection to be deleted

  def delete
    @collection = Collection.find(params[:id])
    @collection.destroy
    redirect_to action: "index"
  end
end
