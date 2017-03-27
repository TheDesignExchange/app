class AdvancedSearch < ActiveRecord::Base
  attr_accessible :keywords, :author, :process

  def design_methods
	@design_methods ||= find_design_methods
  end

  def case_studies
	@case_studies ||= find_case_studies
  end

  private 
	def find_design_methods
	  design_methods = DesignMethod.order(:name)
	  design_methods = design_methods.where("name like ?","%#{keywords}%") if keywords.present?
	  design_methods = design_methods.where("process like ?","%#{process}%") if process.present?
	  design_methods
	end

	def find_case_studies
	  case_studies = CaseStudy.order(:name)
	  case_studies = case_studies.where("name like ?","%#{keywords}%") if keywords.present?
	  case_studies = case_studies.where("process like ?","%#{process}%") if process.present?
	  case_studies
	end
end

