class DraftsController < ApplicationController
	def index
	  @design_methods = DesignMethod.all
	  @case_studies = CaseStudy.all
      @search_filter_hash = MethodCategory.order(:process_order)
      @design_methods_all = DesignMethod.all
      render :layout => "wide"
    end
end
