class ApplicationController < ActionController::Base
  check_authorization :unless => :devise_controller?
  skip_authorization_check :only => [:index, :search, :search_db, :about]
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
    else
      query = params[:query]

      design_method_search = search_db(:dm, query)
      design_methods = design_method_search[:results]
      design_method_facets = design_method_search[:facets]

      case_studies = search_db(:cs, query)[:results]
    end

    @results = {:all => [design_methods, case_studies].flatten,
      :dm => design_methods, :cs => case_studies}
    @category_hashes = build_category_hashes(design_method_facets)

    design_method_names = design_methods.map { |design_method| design_method.name }
    case_study_names = case_studies.map { |case_study| case_study.name }

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

  def search_db(type, query)
    hits = []

    # Process query string
    processed_query = query.gsub( '"', '"\\' ) unless query.blank?

    if not processed_query.blank?
      if type == :dm
        # Sunspot search
        search = DesignMethod.solr_search do
          fulltext processed_query
          facet :method_category_ids
          facet :characteristic_ids
        end
        facets = search.facets
        results = search.results
      elsif type == :cs
        # Sunspot search
        results = CaseStudy.solr_search do
          fulltext processed_query
        end.results
      end
      return {:hits => hits, :results => results, :facets => facets}
    else
      return {:hits => [], :results => []}
    end
  end

  # Adding new extra fields to Devise
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username << :first_name << :last_name
    devise_parameter_sanitizer.for(:account_update) << :username << :first_name << :last_name
  end

  private

  def build_category_hashes(facets)
    cat_facet = facets.find { |f| f.name == :method_category_ids }
    char_facet = facets.find { |f| f.name == :characteristic_ids }

    return MethodCategory.order(:process_order).map do |c|
      category_hash(c, cat_facet, char_facet)
    end
  end

  def category_hash(category, cat_facet, char_facet)
    hit_count = get_facet_count(cat_facet, category.id)
    return {name: category.name,
            id: category.id,
            count: hit_count,
            char_groups: build_char_group_hashes(category, char_facet)}
  end

  def build_char_group_hashes(category, char_facet)
    return category.characteristic_groups.order(:name).map do |cg|
      char_group_hash(cg, char_facet)
    end
  end

  def char_group_hash(cg, char_facet)
    return {name: cg.name,
            id: cg.id,
            chars: build_char_hashes(cg, char_facet)}
  end

  def build_char_hashes(cg, char_facet)
    return cg.characteristics.order(:name).map do |char|
      char_hash(char, char_facet)
    end
  end

  def char_hash(char, char_facet)
    hit_count = get_facet_count(char_facet, char.id)
    return {name: char.name,
            id: char.id,
            count: hit_count}
  end

  def get_facet_count(facet, id)
    row = facet.rows.find {|r| r.value == id}
    return row.nil? ? 0 : row.count
  end
end
