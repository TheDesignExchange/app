class CharacteristicsController < ApplicationController
  load_and_authorize_resource

  def show
    if params[:id]
      @characteristic = Characteristic.where(id: params[:id]).first
      @design_methods = @characteristic.design_methods
    else
      @design_methods = DesignMethod.where("overview != ?", "No overview available" )
    end
     # Filter bar needs
    @search_filter_hash = MethodCategory.all
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
        format.html { redirect_to @characteristic, notice: 'Characteristic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @characteristic.errors, status: :unprocessable_entity }
      end
    end
  end
  def edit
    @characteristic = Characteristic.find(params[:id])
    render layout: "custom"
  end

end

