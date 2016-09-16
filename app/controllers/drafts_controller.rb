class DraftsController < ApplicationController
	def index
	  if (current_user == nil) || (!current_user.admin? || !current_user.editor?)
	  	redirect_to root_path
	  else
	    @design_methods = DesignMethod.all
	    @case_studies = CaseStudy.all
        @search_filter_hash = MethodCategory.order(:process_order)
        @design_methods_all = DesignMethod.all
        render :layout => "wide"
      end
    end
end
