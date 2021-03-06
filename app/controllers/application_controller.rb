require_relative '../../lib/spelling_corrector.rb'
class ApplicationController < ActionController::Base
  include ApplicationHelper
  check_authorization :unless => :devise_controller?

  autocomplete :design_methods, :name

  skip_authorization_check :only => [:landing, :index, :search, :search_db, :about, :share, :sendInvitation,:advancedSearch, :autocomplete_search]
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to :back, :alert => exception.message
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def advancedSearch
    render layout: "custom"
  end

  def autocomplete_search
    @design_method = DesignMethod.order(:name).where("name ILIKE ?", "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.json { 
        render json: @design_method.map(&:name).to_json
      }
    end
  end

  def index
    @design_methods = DesignMethod.order("RANDOM()").limit(3)
    @case_studies = CaseStudy.order("RANDOM()").limit(3)
    render layout: "custom"
  end

  def share
    render layout: "custom"
  end

  def sendInvitation
    UserMailer.invitation_email(params[:email_of_friend],current_user).deliver
    respond_to do |format|
      format.html { redirect_to '/share', notice: 'Invitation was sent!' }
      format.json { head :no_content } 
    end
  end

  def about
    render layout: "custom"
  end

  def search
    # temp param replacement for autocomplete
    if params[:term]
      params[:query] = params[:term]
    end

    if params[:category_id]
      @category = MethodCategory.find(params[:category_id]).name
      @dm_page = params[:dm_page] || 1
      @cs_page = params[:cs_page] || 1

      @cs_tab_visible = params[:visible_tab] == 'cs'
      @dm_search = solr_dm_search("", @dm_page, [], params[:category_id])
      @cs_search = solr_cs_search("", @cs_page)
    else
      @dm_page = params[:dm_page] || 1
      @cs_page = params[:cs_page] || 1
      @query = params[:query] || ""
      cg_filters = params[:char_group_filters] || []

      @cs_tab_visible = params[:visible_tab] == 'cs'
      @dm_search = solr_dm_search(@query, @dm_page, cg_filters, nil)
      @cs_search = solr_cs_search(@query, @cs_page)
    end

    sfh = SearchFilterHash.new(@dm_search.facets, cg_filters)
    @category_hashes = sfh.build_hash
    design_method_names = search_not_draft_or_hidden(@dm_search.results, "dm")
    design_method_names = design_method_names.map { |design_method| design_method.name }
    case_study_names = search_not_draft_or_hidden(@cs_search.results, "cs")
    case_study_names = case_study_names.map { |case_study| case_study.name}
    @dm_names = design_method_names
    @cs_names = case_study_names

    if design_method_names.count == 0
      @autocorrect = ""
      if @query.length < 10
        @autocorrect = correct @query # do optimization in future, but now, dont correct anything longer than 10 letters
      end
      if @autocorrect == @query
        @autocorrect = ""
      end
    end

    @autocomplete_results = [design_method_names, case_study_names].flatten

    # Filter bar needs
    @search_filter_hash = MethodCategory.order(:process_order)

    respond_to do |format|
      format.html do
        render layout: "wide"
      end

      format.json do
        render json: @autocomplete_results
      end
    end
  end

  def solr_dm_search(query, page = 1, cg_filters = [], cat_filter = nil)
    # Process query string
    processed_query = query.gsub( '"', '"\\' )

    return DesignMethod.solr_search do
      fulltext processed_query
      facet :method_category_ids
      facet :characteristic_ids
      paginate :page => page, :per_page => 20

      # characteristics under the same char group joined by OR
      # characteristics under different char groups joined by AND
      cg_filters.each do |cg_id, char_id_strings|
        char_ids = char_id_strings.map(&:to_i)
        with :characteristic_ids, char_ids
      end

      if cat_filter != nil
        with :method_category_ids, cat_filter
      end
    end
  end

  def solr_cs_search(query, page = 1)
    # Process query string
    processed_query = query.gsub( '"', '"\\' )

    return CaseStudy.solr_search do
      fulltext processed_query
      paginate :page => page, :per_page => 20
    end
  end

  # Adding new extra fields to Devise
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username << :first_name << :last_name << :zip_code << :affiliation << :member_type
    devise_parameter_sanitizer.for(:account_update) << :username << :first_name << :last_name << :zip_code << :affiliation << :member_type
  end
end
