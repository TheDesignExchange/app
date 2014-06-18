class MethodsController < ApplicationController
  def home
  	render layout: "wide"
  end

  def create
  	render layout: "wide"
  end

  def view
    id = params['n'].to_i
    if id == 0 then id = 1 end
    dm = DesignMethod.find(id)
    @method = dm
    render layout: "wide"
    # render :json => dm
  end

  def search
  end
end
