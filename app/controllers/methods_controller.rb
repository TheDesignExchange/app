class MethodsController < ApplicationController
  def home
  	render layout: "wide"
  end

  def create
  	render layout: "wide"
  end

  def view
    id = params['n'].to_i
    dm = DesignMethod.find(id)
    @method = dm
    render layout: "custom"
  end

  def search
  end
end
