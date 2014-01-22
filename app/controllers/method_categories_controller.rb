class MethodCategoriesController < ApplicationController

  def show
    @method_category = MethodCategory.find(params[:id])
    @design_methods = @method_category.design_methods.paginate(page: params[:page])
  end

end
