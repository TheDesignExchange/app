class CaseStudiesController < ApplicationController
  def home
    @case_studies = CaseStudy.take(24)
  	render layout: "wide"
  end

  def create
    
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
