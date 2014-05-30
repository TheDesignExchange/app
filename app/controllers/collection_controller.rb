class CollectionController < ApplicationController
layout "custom"
  def casestudies
  	# @casestudies = [
  	# 	{:name => "FedEx Case Study: Leveraging Customer Voice For Co-Creation", :description => "FedEx Innovation spent over five years developing SenseAwareSM, a sensing device combined with a web-based application - a novel application without predecessors. FedEx and Conifer approached this product development using Co-Creation. The Conifer team acted as facilitators and mediators between a group of FedEx customers and the development team. They visited shipping sites and talked to and observed shipping clerks, logistics managers, quality assurance directors, and everyone in between, gaining insight into customers’ day-to-day operations and communication methods."},
  	# 	{:name => "Improving Global Access to HIV Treatment Using Smarter Data: OptimizeARV", :description => "Anti-retroviral therapies (ART) remain the principal mechanism for saving the lives of those infected with HIV/AIDS. The ability of national governments to effectively scale-up their ART treatment programs relies on the recommendations, guidelines, and data produced by global stakeholders such as WHO, PEPFAR. National governments struggle to assimilate this knowledge effectively because of information fragmentation and limited analytical capacity."},	
  	# ]

  	@casestudies = CaseStudy.all
  end
  def form
  	id = params["n"] == nil ? 1 : params["n"].to_i
    # render :text => id
  	@cs = CaseStudy.where("id=?", id).first;
  end
end
