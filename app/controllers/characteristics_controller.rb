class CharacteristicsController < ApplicationController
  def show 
    if params[:id]
      id = params[:id].to_i
      @characteristic = Characteristic.where(id: params[:id]).first
      @design_methods = @characteristic.design_methods   
      @search_filter_hash = MethodCategory.all
      @design_methods_all = DesignMethod.all
      respond_to do |format|  
        format.html { render :layout => "wide" }
        format.json { render json: @design_methods_all} 
      end  
    else 
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
  end 
end 

