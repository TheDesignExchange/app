class DeController < ApplicationController

  def index
  	@design_methods = DesignMethod.where("overview != ?", "default" ).take(3)
  	@case_studies = CaseStudy.take(3)
    @discussions = Discussion.take(2)
  	# render :text => sidebar_hash(:methods)
  	render layout: "custom"
  end

  def search
    query = params["q"] ? params['q'].gsub(' ', '_') : "";
    design_methods = search_db(:dm, query, 24)[:results]
  	case_studies = search_db(:cs, query, 24)[:results]
    discussions = search_db(:disc, query, 24)[:results]

    @results = {:all => [design_methods, case_studies, discussions].flatten.shuffle[0..24],
      :dm => design_methods, :cs => case_studies, :disc => discussions}
    # render :json => params["q"].length
    render layout: "wide"
  end

  # Search design methods.
  #
  # === Parameters
  # - query: the search term
  #
  # === Variables
  # - @results: list of design methods from the search result
  def search_db(type, query, limit)
    hits = []
    if query
      if type == :dm
        results = DesignMethod.where("LOWER( design_methods.name ) LIKE ?", "%#{query}%")
        .order('name = "'+ query +'" DESC, name LIKE "'+ query +'%" DESC'); 
      elsif type == :cs
        results = CaseStudy.where("LOWER( case_studies.title ) LIKE ?", "%#{query}%")
        .order('title = "'+ query +'" DESC, title LIKE "'+ query +'%" DESC'); 
      else
        results = Discussion.where("LOWER( discussions.title ) LIKE ?", "%#{query}%")
        .order('title = "'+ query +'" DESC, title LIKE "'+ query +'%" DESC'); 
      end
      return {:hits => hits, :results => results}
    else
      return {:hits => [], :results => []}
    end
  end



end
