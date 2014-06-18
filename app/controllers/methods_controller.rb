class MethodsController < ApplicationController
  layout "wide"

  def home
    @design_methods = DesignMethod.where("overview != ?", "default" ).take(24)
  end

  def create
  end

  def view
    id = params['n'].to_i
    if id == 0 then id = 1 end
    dm = DesignMethod.find(id)
    @method = dm
    # render :json => dm
  end

  def search
  end
end
