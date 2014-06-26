class MethodsController < ApplicationController

  def home
    @design_methods = DesignMethod.where("overview != ?", "default" ).take(24)
    render :layout => "wide"
  end

  def create
    id = params["n"] == nil ? 1 : params["n"].to_i
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
    id = params['n'].to_i
    #default to method id #1 TODO remove
    if id == 0 then id = 1 end
    dm = DesignMethod.find(id)
    @method = dm
    @author = dm.owner
    @citations = dm.citations
    render :layout => "custom"
  end

  def search
    render :layout => "wide"
  end
end
