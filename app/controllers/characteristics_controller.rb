class CharacteristicsController < ApplicationController
  load_and_authorize_resource

  def new
    render layout: "custom"
  end

  def create
    @characteristic = Characteristic.new(params[:characteristic])
    respond_to do |format|
      if @characteristic.save
        @citations
        format.html { redirect_to administrator_path, notice: 'Characteristic was successfully created.' }
        format.json { render json: @characteristic, status: :created, location: @design_method }
      else
        format.html { render action: "new" }
        format.json { render json: @design_method.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    if params[:id]
      @characteristic = Characteristic.where(id: params[:id]).first
      @design_methods = @characteristic.design_methods
    else
      @design_methods = DesignMethod.where("overview != ?", "No overview available" )
    end
     # Filter bar needs
    @search_filter_hash = MethodCategory.order(:process_order)
    @design_methods_all = DesignMethod.all
    respond_to do |format|
      format.html { render :layout => "wide" }
      format.json { render json: @design_methods_all}
    end
  end

  def update
    @characteristic = Characteristic.find(params[:id])
    respond_to do |format|
      if @characteristic.update_attributes(params[:characteristic])
        format.html { redirect_to administrator_path, notice: 'Characteristic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @characteristic.errors, status: :unprocessable_entity }
      end
    end
  end
  def edit
    @characteristic = Characteristic.find(params[:id])
    @characteristic_group = CharacteristicGroup.find_by(id: @characteristic.characteristic_group_id)
    render layout: "custom"
  end

  def destroy
    @characteristic = Characteristic.find(params[:id])
    Characteristic.delete(@characteristic)
    respond_to do |format|
        format.html { redirect_to administrator_path, notice: 'Characteristic was successfully deleted.' }
    end
  end

end

