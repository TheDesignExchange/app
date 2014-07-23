class CaseStudiesController < ApplicationController
  def index
    @case_studies = CaseStudy.where("description != ?", "No description available" ).take(24)
  	render layout: "wide"
  end

  def new
    id = params[:id] == nil ? 1 : params[:id].to_i
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
    id = params[:id] == nil ? 1 : params[:id].to_i
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

  def show
    id = params[:id].to_i
    cs = CaseStudy.find(id)
    @casestudy = cs
    @author = @casestudy.company.name

    @similar_methods = @casestudy.similar_methods(100,6)
    @similar_case_studies = @casestudy.similar_case_studies(100,6)
    render layout: "custom"
  end

  def search

  end
end
