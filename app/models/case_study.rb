class CaseStudy < ActiveRecord::Base
	belongs_to :company
	has_many :contacts
	has_many :resources

    # METHOD LINKING 
    has_many :method_case_studies
    has_many :design_methods, :through => :method_case_studies
	# validates :development_cycle,
 #    :inclusion  => { :in => ["Product Update", "Product Refinement", "New Product", "Other"],
 #    :message    => "%{value} is not a development cycle" }

    def self.options
    	return {:development_cycle => ["Product Update", "Product Refinement", "New Product", "Other"],
    			:design_phase => [ "Problem Assessment", "Conceptual Design", "Detailed Design", "Other"] , 
    			:project_domain => ["Built Environment", "Product", "Service", "Web", "Mobile", "Graphic", "Fashion", "Other"],
    			:customer_type => ["Government", "Educational Group", "Business", "NGO", "Other"],
    			:user_age => ["Child", "Teen", "Young Adult", "Middle Aged", "Elderly" ],
    			:privacy_level => ["Private", "Public"],
  	 			:social_setting => ["Personal", "Social", "Professional"]

    	}
    end
    def self.helper_text
        return {
            :design_phase => ["The phase involves acquiring or processing information, or defining the problem.", "This phase involves generating or evaluating concepts or prototyping." ,"This phase involves prototyping, manufacturing and deployment."],
            :remoteProject => ["remote project = online project"],
            :privacy_level => [" <em> Private </em> means only select few can observe the activity, and effort must be put to respect customs of activity. <span>(Example: religious ceremony)</span>", " <em>Public</em> means activity can be observed by anyone who desires to see the activity."],
            :social_setting => [" <em>Personal</em> includes individual, couple and family.", " <em>Social</em> includes friends, communities (religion, political group) and individual in social context.", " <em>Professional</em> includes work, education, medical and government."]
        }
    end
end
