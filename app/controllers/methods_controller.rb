class MethodsController < ApplicationController

  def home
    @design_methods = DesignMethod.where("overview != ?", "No overview available" ).take(24)
    render :layout => "wide"
  end

  def create
    id = params[:id] == nil ? 1 : params[:id].to_i
    # render :text => id
    @cs = CaseStudy.where("id=?", id).first;

    @attr = CaseStudy.columns_hash;
    @company = @cs.company
    @contacts = @company.contacts()
    @methods = @cs.design_methods().reverse;

    @attr.delete("id")
    @attr.delete("company_id")
    @attr.delete("created_at")
    @attr.delete("updated_at")
    @options = CaseStudy.options()
    @helper_text = CaseStudy.helper_text()

    render :layout => "custom"

  end

  def view
    id = params[:id].to_i
    #default to method id #1 TODO remove
    if id == 0 then id = 1 end
    dm = DesignMethod.find(id)
    @method = dm
    @author = dm.owner
    @citations = dm.citations
    @similar_methods = @method.similar_methods(100,6)
    @similar_case_studies = @method.similar_case_studies(100,6)
    render :layout => "custom"
    # render :json => @method.neighbors(100, 6)
  end

  def search
    render :layout => "wide"
  end
end
