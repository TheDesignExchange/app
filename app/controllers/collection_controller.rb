class CollectionController < ApplicationController
layout "custom"
  def links
     if not params["n"] 
      render :json => "Fail" 
    else 
      id = params["n"]
      cs = CaseStudy.where("id=?", id).first;
      methods = cs.design_methods().each{|x| x.name = x.name.humanize() }.reverse;
      render :json => methods
    end
  end
  def removemethod
    if not params["m"] or not params["cs"] 
      render :json => "Fail" 
    else 
      mname= params["m"].strip().gsub(' ', '_');
      csid = params["cs"];
      m = DesignMethod.where('name like  ?', "#{mname}%").first
      mid = m.id
      r = MethodCaseStudy.where("case_study_id = ? and design_method_id = ?", csid, mid).first()
      r.destroy
      render :json => r
    end
  end
  def linkmethod
    if not params["m"] or not params["cs"] 
      render :json => "Fail" 
    else 
      mname= params["m"].gsub(' ', '_');
      csid = params["cs"];
      m = DesignMethod.where('name like  ?', "#{mname}%").first
      mid = m.id
      link = MethodCaseStudy.new({:case_study_id => csid, :design_method_id => mid}).save
      render :json => link
    end
  end
  def linkmethods
    prefix = "b"
    search = DesignMethod.where('name like  ?', "#{prefix}%").map{|x| x.name}
    query = "Focus Groups".gsub(' ', '_')
    # search = DesignMethod.where('name like  ?', query)
    # CaseStudy.first.design_methods()
    cs = CaseStudy.first
    m = cs.methods.split(',').map{|x| x.strip.gsub(' ', '_')}
    debug = []
    m.each do |x|
      method = DesignMethod.where('name like  ?', "#{x}%").first;
      debug << [x, method]
      if method
        debug << [cs.id, method.id]
        debug << MethodCaseStudy.new({:case_study_id => cs.id, :design_method_id => method.id}).save
      end
    end
    render :json => debug
  end
  def casestudies
  	# @casestudies = [
  	# 	{:name => "FedEx Case Study: Leveraging Customer Voice For Co-Creation", :description => "FedEx Innovation spent over five years developing SenseAwareSM, a sensing device combined with a web-based application - a novel application without predecessors. FedEx and Conifer approached this product development using Co-Creation. The Conifer team acted as facilitators and mediators between a group of FedEx customers and the development team. They visited shipping sites and talked to and observed shipping clerks, logistics managers, quality assurance directors, and everyone in between, gaining insight into customers’ day-to-day operations and communication methods."},
  	# 	{:name => "Improving Global Access to HIV Treatment Using Smarter Data: OptimizeARV", :description => "Anti-retroviral therapies (ART) remain the principal mechanism for saving the lives of those infected with HIV/AIDS. The ability of national governments to effectively scale-up their ART treatment programs relies on the recommendations, guidelines, and data produced by global stakeholders such as WHO, PEPFAR. National governments struggle to assimilate this knowledge effectively because of information fragmentation and limited analytical capacity."},	
  	# ]

  	@casestudies = CaseStudy.all

    # [title=casjdlkjaslkd, desc, adlkasjdlkj]
    @companies = CaseStudy.all.map{|c| c.company }
    @contacts = @companies.map{|c| c.contacts }

    # @companies = CaseStudy.all.map{|c| c.contacts }
    # @companies = CaseStudy.all.map{|c| c.methods }
    # [Aegis, Ideo, ]
    
    #MAP DESIGN PATTERN

    # test = @casestudies
    # render :json => test
  end


  def form
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
    # @company = Company.new({:domain => "Education", :name => "University of California at Berkeley"});
    # @company.save
    # @company = Company.where("name = ?", "University of California at Berkeley").first.contacts
    # render :json => @methods
  end


  def send_casestudy
    render :json => params
  end

  def autocomplete_design_methods
    prefix = params['term']
    render :json => DesignMethod.where('name like  ?', "#{prefix}%").map{|x| x.name.humanize}
  end
end
