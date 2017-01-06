class CaseStudyAdvancedSearch < ActiveRecord::Base
  attr_accessible :keywords, :sector

  def case_studies
	@case_studies ||= find_case_studies
  end

  private 
	def find_case_studies
	  case_studies = CaseStudy.order(:name)
	  case_studies = case_studies.where("name like ?","%#{keywords}%") if keywords.present?
	  case_studies = case_studies.where("? = ANY(industry_sectors)", "#{sector}") if sector.present?
	  case_studies
	end
end
