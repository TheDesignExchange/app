class MethodsController < ApplicationController
  layout "custom"

  def home
    @design_methods = DesignMethod.where("overview != ?", "default" ).take(24)
    render :layout => "wide"
  end

  def create
  end

  def view
    id = params['n'].to_i
    #default to method id #1 TODO remove
    if id == 0 then id = 1 end
    dm = DesignMethod.find(id)
    @method = dm
    @author = dm.owner
    @citations = dm.citations
    render :layout => "custom"
  end

  def search
    render :layout => "wide"
  end
end
