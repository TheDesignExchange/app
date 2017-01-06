class CaseStudyAdvancedSearch < ActiveRecord::Base
  attr_accessible :keywords

  def case_studies
	@case_studies ||= find_case_studies
  end

  private 

	def find_case_studies
	  case_studies = CaseStudy.order(:name)
	  case_studies = case_studies.where("name like ?","%#{keywords}%") if keywords.present?
	  case_studies
	end
end
