class ApplicationController < ActionController::Base
  check_authorization :unless => :devise_controller?
  skip_authorization_check :only => [:index, :search, :search_db, :about]
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

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
    render layout: "custom"
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def index
    @design_methods = DesignMethod.take(3)
    @case_studies = CaseStudy.take(3)
    render layout: "custom"
  end

  def search
    # TODO fix this
    # 1. characteristic facet grouping: OR vs AND
    # 2. add char ids to search as facet and display these in filters
    # 3. get search button from filters to send search back with these as new
    # params and apply
    # 4. Use scoping for category pages
    # eg
    # DesignMethod.solr_search do
    #   fulltext your_query_here
    #   with(:characteristic_ids, [1, 2, 3]) <--- works like OR
    #   with(:characteristic_ids, 8) <---- works like AND
    #   facet :characteristic_ids
    #   facet :method_category_ids (maybe)
    #   paginate :page => 1, :per_page => 24
    #   (http://sunspot.github.io/sunspot/docs/#Pagination)
    #   order_by option for sorting by date, name, relevancy, etc
    #
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

  # Addinv new extra fields to Devise
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username << :first_name << :last_name
    devise_parameter_sanitizer.for(:account_update) << :username << :first_name << :last_name
  end
end
