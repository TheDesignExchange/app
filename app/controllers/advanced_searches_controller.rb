class AdvancedSearchesController < InheritedResources::Base

  private

    def advanced_search_params
      params.require(:advanced_search).permit()
    end
end

