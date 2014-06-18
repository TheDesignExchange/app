class DeController < ApplicationController

  def index

  	@design_methods = DesignMethod.where("overview != ?", "default" ).take(3)
  	# hm = DesignMethod.first.method_categories
  	@case_studies = CaseStudy.take(3)
  	# render :json => hm
  	render layout: "custom"
  end

  def search
  	@design_methods = DesignMethod.where("overview != ?", "default" ).take(24)
  	@case_studies = CaseStudy.take(3)
  	render layout: "wide"
  end

  # <button oasdhfkljahsd;fh onclick="location.href = '/de/index'; "> 
end
