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
    	# @design_methods = DesignMethod.where("overview != ?", "No overview available" ).take(3)
    	# @case_studies = CaseStudy.where("overview != ?", "No overview available").take(3)
      @design_methods = DesignMethod.take(3)
      @case_studies = CaseStudy.take(3)
      @discussions = Discussion.take(2)
    	# render :text => sidebar_hash(:methods)
    	render layout: "custom"
    end

  def search

    # temp param replacement for autocomplete
    if params[:term]
      params[:query] = params[:term]
    end

    query = params[:query]

    design_methods = search_db(:dm, query, 24)[:results]
  	case_studies = search_db(:cs, query, 24)[:results]
    discussions = search_db(:disc, query, 24)[:results]

    @results = {:all => [design_methods, case_studies, discussions].flatten.shuffle[0..24],
      :dm => design_methods, :cs => case_studies, :disc => discussions}

    design_method_names = design_methods.map { |design_method| design_method.name }
    case_study_names = case_studies.map { |case_study| case_study.title }
    discussion_names = discussions.map { |discussion| discussion.title }

    @autocomplete_results = [design_method_names, case_study_names, discussion_names].flatten

    respond_to do |format|
      format.html do
        render layout: "wide"
      end

      format.json do
        render json: @autocomplete_results
      end
    end
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
        # results = DesignMethod.where("LOWER( design_methods.name ) LIKE ? AND overview != ? ", "%#{query}%", "No overview available")

        # Sunspot search
        results = DesignMethod.solr_search do

          fulltext query.gsub( '"', '"\\' ) unless query.blank?

        end.results

      elsif type == :cs
        # Sunspot search
        results = CaseStudy.solr_search do

          fulltext query.gsub( '"', '"\\' ) unless query.blank?

        end.results
      else
        # Sunspot search
        results = Discussion.solr_search do

          fulltext query.gsub( '"', '"\\' ) unless query.blank?

        end.results
      end
      return {:hits => hits, :results => results}
    else
      return {:hits => [], :results => []}
    end
  end

  def about
  end


  # Addinv new extra fields to Devise
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username << :first_name << :last_name
    devise_parameter_sanitizer.for(:account_update) << :username << :first_name << :last_name
  end
end
