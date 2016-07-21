class ApplicationController < ActionController::Base
  check_authorization :unless => :devise_controller?
  skip_authorization_check :only => [:index, :search, :about]
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def index
    @design_methods = DesignMethod.order("RANDOM()").limit(3)
    @case_studies = CaseStudy.order("RANDOM()").limit(3)
    render layout: "custom"
  end

  def about
    render layout: "custom"
  end

  def search
    # TODO fix this
    # 1. DONE characteristic facet grouping: OR vs AND
    # 2. DONE add char ids to search as facet and display these in filters
    # 3. DONE get search button from filters to send search back with these as new
    # params and apply
    # 4. Use scoping for category pages
    # 5. Sorting
    # 6. Pagination
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
      # design_methods = MethodCategory.find(params[:category_id]).design_methods
      # case_studies = []
    else
      page = params[:page] || 1
      query = params[:query] || ""
      cg_filters = params[:char_group_filters] || []

      @dm_search = solr_dm_search(query, page, cg_filters)
      @cs_search = solr_cs_search(query, page)
    end

    sfh = SearchFilterHash.new(@dm_search.facets, cg_filters)
    @category_hashes = sfh.build_hash

    design_method_names = @dm_search.results.map { |design_method| design_method.name }
    case_study_names = @cs_search.results.map { |case_study| case_study.name }

    @autocomplete_results = [design_method_names, case_study_names].flatten

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

  def solr_dm_search(query, page = 1, cg_filters = [])
    # Process query string
    processed_query = query.gsub( '"', '"\\' )

    return DesignMethod.solr_search do
      fulltext processed_query
      facet :method_category_ids
      facet :characteristic_ids
      paginate :page => page, :per_page => 24

      # characteristics under the same char group joined by OR
      # characteristics under different char groups joined by AND
      cg_filters.each do |cg_id, char_id_strings|
        char_ids = char_id_strings.map(&:to_i)
        with :characteristic_ids, char_ids
      end
    end
  end

  def solr_cs_search(query, page = 1)
    # Process query string
    processed_query = query.gsub( '"', '"\\' )

    return CaseStudy.solr_search do
      fulltext processed_query
    end
  end

  # Adding new extra fields to Devise
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username << :first_name << :last_name
    devise_parameter_sanitizer.for(:account_update) << :username << :first_name << :last_name
  end
end
