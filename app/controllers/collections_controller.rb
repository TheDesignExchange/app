class CollectionsController < ApplicationController
	def index
		@collections = Collection.all
		render :layout => "custom"
	end

  def new
  	@collection = Collection.new
  	render :layout => "custom"
  end

  def create

  	@collection = Collection.new(params[:collection])
  	
  	method_id = request.referrer.scan( /\d+$/ ).first
  	@method = DesignMethod.find(method_id)
  	respond_to do |format|
  		@collection.update_attribute(:name, params[:collection][:name])
  		@collection.update_attribute(:owner_id, current_user.id)
  		@collection.design_methods.push(@method)
      if @collection.save
      	puts @collection.inspect
        format.html { redirect_to :back, notice: 'Set was successfully created.'}
        format.json { render json: @collection, status: :created, location: @collection }
      else
        format.html { redirect_to :back, notice: 'Set was not created due to errors.' }
       	format.json { render json: @collection, status: :created, location: @collection }
      end
    end
  end

  def show
  	id = params[:id].to_i
  	@collection = Collection.find(id)
  	render :layout => "custom"
  end

  def add_method
  	puts "ID IS HERE!!!!!!!!!!!!!!"
  	puts params[:col_id]
    @collection = Collection.find(params[:col_id])
    @method = DesignMethod.find(params[:method_id])
    @collection.design_methods.push(@method)
    respond_to do |format|
	    if @collection.save
	    	puts @collection.inspect
	      format.html { redirect_to :back, notice: 'Method was successfully added to Set.'}
	      format.json { render json: @collection, status: :created, location: @collection }
	    else
	      format.html { redirect_to :back, notice: 'Method was not added to Set due to errors.' }
	     	format.json { render json: @collection, status: :created, location: @collection }
	    end
	  end
  end




end
