class DeController < ApplicationController

  def index
  	@design_methods = DesignMethod.where("overview != ?", "default" ).take(3)
  	@case_studies = CaseStudy.take(3)
  	# render :json => hm
  	render layout: "custom"
  end

  def search
    query = params["q"] ? params['q'].gsub(' ', '_') : "";
  	# @design_methods = 
  	@design_methods = search_db(query, 24)[:results]
    # render :json => @design_methods.map{|x| x.name}
    render layout: "wide"
  end

  # Search design methods.
  #
  # === Parameters
  # - query: the search term
  #
  # === Variables
  # - @results: list of design methods from the search result
  def search_db(query, limit)
    hits = []
    if query
      results = DesignMethod.where("LOWER( design_methods.name ) LIKE ?", "%#{query}%")
      .order('name = "'+ query +'" DESC, name LIKE "'+ query +'%" DESC'); 

      # DesignMethod.where("name LIKE ? and overview != ?", "%#{query}%", "default").limit(limit);
      # search = DesignMethod.solr_search do
      #   fulltext params[:query] do
      #     highlight
      #     minimum_match 0
      #   end
      # end
      # store_location
      # hits = search.hits
      # results = search.results
      return {:hits => hits, :results => results}
    else
      return {:hits => [], :results => []}
    end
  end



end
