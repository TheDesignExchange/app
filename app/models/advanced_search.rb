class AdvancedSearch < ActiveRecord::Base
  attr_accessible :keywords, :author, :process

  def design_methods
	@design_methods ||= find_design_methods
  end

  private 
	def find_design_methods
	  design_methods = DesignMethod.order(:name)
	  design_methods = design_methods.where("name like ?","%#{keywords}%") if keywords.present?
	  design_methods = design_methods.where("process like ?","%#{process}%") if process.present?
	  design_methods
	end
end

