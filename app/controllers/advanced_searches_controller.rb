require 'dx/props'
require "uri"

class AdvancedSearchesController < InheritedResources::Base
  load_and_authorize_resource

  def create
  	@advanced_search = AdvancedSearch.create!(params[:advanced_search])
  	redirect_to @advanced_search

  end	

  def show
  	@advanced_search = AdvancedSearch.find(params[:id])
    render layout: "custom"
  end

  def new
  	@advanced_search = AdvancedSearch.new
    render layout: "custom"

  end

end

