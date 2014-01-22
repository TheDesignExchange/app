class CitationsController < ApplicationController
  def show
    @citations = Citation.find(params[:id])
    @design_methods = @citations.design_methods.paginate(page: params[:page])
  end
end
