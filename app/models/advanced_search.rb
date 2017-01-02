class AdvancedSearch < ActiveRecord::Base
  attr_accessible :keywords

  def design_methods
	@design_methods ||= find_design_methods
  end

  private 
	def find_design_methods
	  design_methods = DesignMethod.order(:name)
	  design_methods = DesignMethod.where("name like ?","%#{keywords}%") if keywords.present?
	  design_methods
	end
end

