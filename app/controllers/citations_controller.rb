class CitationsController < ApplicationController
  load_and_authorize_resource

  def show
    @citations = Citation.find(params[:id])
    @design_methods = @citations.design_methods.paginate(page: params[:page])
  end
end
