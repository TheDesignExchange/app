class CaseStudyAdvancedSearchesController < InheritedResources::Base
  load_and_authorize_resource

  def create
  	@advanced_search = CaseStudyAdvancedSearch.create!(params[:case_study_advanced_search])
  	redirect_to @advanced_search
  end	

  def show
  	@advanced_search = CaseStudyAdvancedSearch.find(params[:id])
    render layout: "custom"
  end

  def new
  	@advanced_search = CaseStudyAdvancedSearch.new
    render layout: "custom"
  end

end

