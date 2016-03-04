class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info


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

    if params[:category_id]
      design_methods = MethodCategory.find(params[:category_id]).design_methods
      case_studies = []
      discussions = []
    else
      query = params[:query]

      design_methods = search_db(:dm, query, 24)[:results]
    	case_studies = search_db(:cs, query, 24)[:results]
      discussions = search_db(:disc, query, 24)[:results]
    end

    @results = {:all => [design_methods, case_studies, discussions].flatten,
      :dm => design_methods, :cs => case_studies, :disc => discussions}

    # TEMP LOGIC for Carmen Class Experiment
    if params[:category_id]=="3"
      highlight_methods = design_methods.find([109,66,106,62])
      other_methods = design_methods.where.not(id: [109,66,106,62])
      @results = {:highlight_methods => highlight_methods, :other_methods => other_methods,
        :dm => design_methods, :cs => case_studies, :disc => discussions}
    end
    # END TEMP LOGIC

    design_method_names = design_methods.map { |design_method| design_method.name }
    case_study_names = case_studies.map { |case_study| case_study.name }
    discussion_names = discussions.map { |dis| dis.name }

    @autocomplete_results = [design_method_names, case_study_names, discussion_names].flatten


    # Filter bar needs
    @search_filter_hash = MethodCategory.all



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

    # Process query string
    processed_query = query.gsub( '"', '"\\' ) unless query.blank?

    if not processed_query.blank?
      if type == :dm
        # results = DesignMethod.where("LOWER( design_methods.name ) LIKE ? AND overview != ? ", "%#{query}%", "No overview available")

        # Sunspot search
        results = DesignMethod.solr_search do
          fulltext processed_query
        end.results

      elsif type == :cs
        # Sunspot search
        results = CaseStudy.solr_search do
          fulltext processed_query
        end.results
      else
        # Sunspot search
        results = Discussion.solr_search do
          fulltext processed_query
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
