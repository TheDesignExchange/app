class CollectionsController < ApplicationController
	def index
		@collections = Collection.all

		#@private_collections = Collection.where(is_private: true)
		@public_collections = Collection.where(is_private: false) 
		render :layout => "custom"
	end

  def new
  	@collection = Collection.new
  	render :layout => "custom"
  end

  def create

  	@collection = Collection.new(params[:collection])

  	url = request.referrer

  	if url =~ /\/([^\/]+)(?=\/[^\/]+\/?\Z)/
		  match = $~[1]
		else
		  match = ""
		end

		if !match.blank?
			if match == "design_methods"
				method_id = url.scan( /\d+$/ ).first
  			@method = DesignMethod.find(method_id)
  			@collection.design_methods.push(@method)
  		end
  		if match == "case_studies"
  			cs_id = url.scan( /\d+$/ ).first
  			@case_study = CaseStudy.find(cs_id)
  			@collection.case_studies.push(@case_study)
  		end
		end
  	
  	#method_id = request.referrer.scan( /\d+$/ ).first
  	#@method = DesignMethod.find(method_id)
  	respond_to do |format|
  		@collection.update_attribute(:name, params[:collection][:name])
  		@collection.update_attribute(:owner_id, current_user.id)
  		#@collection.design_methods.push(@method)
      if @collection.save
        format.html { redirect_to :back, notice: 'Set was successfully created.'}
        format.json { render json: @collection, status: :created, location: @collection }
      else
      	@collection.destroy
        format.html { redirect_to :back, :flash => { :warning => "New Set must have a name." } }
       	#format.json { render json: @collection, status: :unprocessable_entity, location: @collection }
      end
    end
  end

  def show
  	id = params[:id].to_i
  	@user = current_user
  	@collection = Collection.find(id)
  	puts @collection.design_methods
  	puts @collection.case_studies
  	render :layout => "custom"
  end

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

    #@method = DesignMethod.find(params[:method_id])
    #@collection.design_methods.push(@method)
    respond_to do |format|
	    if @collection.save
	    	puts @collection.inspect
	      format.html { redirect_to :back, notice: 'Successfully added to Set.'}
	      format.json { render json: @collection, status: :created, location: @collection }
	    else
	      format.html { redirect_to :back, :flash => { :warning => "Not added to Set due to errors." } }
	     	format.json { render json: @collection, status: :created, location: @collection }
	    end
	  end
  end

  def remove
  	col_id = request.referrer.scan( /\d+/ ).last
  	@collection = Collection.find(col_id)

  	id = params[:id]
  	
  	url = request.original_url

  	if url.include? "design_methods"
    	@method = DesignMethod.find(id)
    	@collection.design_methods.delete(@method)
    end
    if url.include? "case_studies"
    	@case_study = CaseStudy.find(id)
    	@collection.case_studies.delete(@case_study)
    end

  	respond_to do |format|
  		if @collection.save
  			format.html { redirect_to :back, notice: 'Removed from Set.'}
	    	format.json { render json: @collection, status: :created, location: @collection }
	    else
	    	format.html { redirect_to :back, :flash => { :warning => "Set must have at least one method or case study." } }
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
    puts "COLLECTION METHODS HERE!!!!"
    puts @collection.design_methods
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


  def change_privacy
  	@collection = Collection.find(params[:id])
  	if @collection.is_private?
  		@collection.update_attribute(:is_private, false)
  	else
  		@collection.update_attribute(:is_private, true)
  	end
  	@collection.save
  	respond_to do |format|
  		format.html { redirect_to :back, notice: 'Privacy changed.'}
	    format.json { render json: @collection, status: :created, location: @collection }
	  end
  end

  def delete
  	@collection = Collection.find(params[:id])
  	@collection.destroy
  	redirect_to action: "index"
  end

  def methods
  	@collection = Collection.find(params[:id])
  	render :layout => "custom"
  end

  def studies 
    @collection = Collection.find(params[:id])
    render :layout => "custom"
  end


end
