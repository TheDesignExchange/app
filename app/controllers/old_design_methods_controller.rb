# == Description
# Controller for DesignMethod.

class DesignMethodsController < ApplicationController
  # Page for DesignMethod browsing.
  #
  # Currently displays all methods, but in the future should display different sets of methods such
  # as most popular, recommended, featured, etc.
  #
  # === Variables
  # - @design_methods: all design methods
  def index
    if params[:user_id]
      @user = User.find(params[:id])
      @design_methods = @user.owned_methods.paginate(page: params[:page])
    else
      @user = current_user
      @design_methods = DesignMethod.all.paginate(page: params[:page])
    end
    store_location
  end

  # Search design methods.
  #
  # === Parameters
  # - query: the search term
  #
  # === Variables
  # - @results: list of design methods from the search result
  def search
    @hits = []

    if params[:query]
      search = DesignMethod.solr_search do
        fulltext params[:query] do
          highlight
          minimum_match 0
        end
      end
      store_location
      @hits = search.hits
      @results = search.results
    end

    respond_to do |format|
      format.html
      format.json { render json: @results }
    end
  end

  # Provide design methods for autocomplete.
  #
  # === Parameters
  # - term: the search term
  #
  # === Variables
  # - @design_methods: all the design methods matching the term
  # - @design_hash: correctly formatted json for jquery.
  def autocomplete
    @design_methods = DesignMethod.where(['name LIKE ?', "#{params[:term]}%"])
    @design_hash = []
    @design_methods.each do |d|
      @design_hash << { label: d.name }
    end
    respond_to do |format|
      format.json { render json: @design_hash}
    end
  end

  # View details of a single DesignMethod.
  #
  # === Parameters
  # - id: ID of design method
  #
  # === Variables
  # - @design_method: design method corresponding to given ID
  # - @categories: categories that this method falls under
  def show
    @design_method = DesignMethod.find(params[:id])
    @categories = @design_method.method_categories
    @citations = @design_method.citations
    @back = redirect_back

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @design_method }
    end
  end

  # Create a new DesignMethod
  #
  # === Variables
  # - @design_method: initialized new DesignMethod object
  def new
    @design_method = DesignMethod.new
  end

  # Edit an existing DesignMethod
  #
  # === Parameters
  # - id: ID of the design method to be edited
  #
  # === Variables
  # - @design_method: the design method to be edited
  def edit
    @design_method = DesignMethod.find(params[:id])
  end


  # Creates a DesignMethod
  #
  # === Request Body
  # - design_method: a hash containing the required fields for creating a DesignMethod
  #
  # === Variables
  # - @design_method: the newly created design method
  def create
    @design_method = DesignMethod.new(design_method_params)
    @design_method.owner = current_user

    respond_to do |format|
      if @design_method.save
        format.html { redirect_to @design_method, notice: 'Design method was successfully created.' }
        format.json { render json: @design_method, status: :created, location: @design_method }
      else
        format.html { render action: "new" }
        format.json { render json: @design_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # Update an existing DesignMethod corresponding to the ID in the URI
  #
  # === Variables
  # - design_method: the deleted design method
  def destroy
    @design_method = DesignMethod.find(params[:id])
    @design_method.destroy

    respond_to do |format|
      format.html { redirect_to redirect_back }
      format.json { head :no_content }
    end
  end

  private

    def design_method_params
      params.require(:design_method).permit(
        :name, :overview, :process, :principle
      )
    end

    def redirect_back
      if session[:return_to]
        back = session[:return_to]
        session.delete(:return_to)
        back
      else
        design_methods_url
      end
    end

  # end private
end
