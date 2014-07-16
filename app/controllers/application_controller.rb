class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

    # The DesignExchange home page.
    #
    # If viewed without logging in, should display some information about the site and direct the
    # user to sign-up or search for methods.
    #
    # If logged in, should show activity feed (to be developed), any update information (to be
    # determined), and navigation for basic tasks.
    def home
      if current_user
        @recently_created_methods = current_user.owned_methods.order("created_at DESC").limit(10)
        store_location
      end
    end

    # Show information about the project itself
    def about
    end

    # Show contact information about the project members
    def contact
    end
  	def store_location
  		session[:return_to] = request.url if request.get?
  	end

  	def index
  	@design_methods = DesignMethod.where("overview != ?", "No overview available" ).take(3)
  	@case_studies = CaseStudy.where("description != ?", "No description available").take(3)
    @discussions = Discussion.take(2)
  	# render :text => sidebar_hash(:methods)
  	render layout: "custom"
  end

  def search
    query = params[:query] ? params[:query].gsub(' ', '_') : "";
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
        results = DesignMethod.where("LOWER( design_methods.name ) LIKE ? AND overview != ? ", "%#{query}%", "No overview available")
        .order('name = "'+ query +'" DESC, name LIKE "'+ query +'%" DESC'); 
      elsif type == :cs
        results = CaseStudy.where("LOWER( case_studies.title ) LIKE ? AND description != ?", "%#{query}%", "No description available")
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
  def about
  end
end