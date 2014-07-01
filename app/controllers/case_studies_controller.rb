class CaseStudiesController < ApplicationController
  def home
    @case_studies = CaseStudy.take(24)
  	render layout: "wide"
  end

  def create
    id = params["n"] == nil ? 1 : params["n"].to_i
    # render :text => id
    @cs = CaseStudy.where("id=?", id).first;

    @attr = CaseStudy.columns_hash;
    @company = @cs.company
    @contacts = @company.contacts()
    @methods = @cs.design_methods().reverse;
    @options = CaseStudy.options()
    @helper_text = CaseStudy.helper_text()

    render :layout => "custom"
  end
  def edit
    id = params["n"] == nil ? 1 : params["n"].to_i
    # render :text => id
    @cs = CaseStudy.where("id=?", id).first;

    @attr = CaseStudy.columns_hash;
    @company = @cs.company
    @contacts = @company.contacts()
    @methods = @cs.design_methods().reverse;
    @options = CaseStudy.options()
    @helper_text = CaseStudy.helper_text()

    render :layout => "custom"
  end

  def view
    id = params['n'].to_i
    cs = CaseStudy.find(id)
    @casestudy = cs
    @author = cs.company()
    render layout: "custom"
  end

  def search

  end
end
