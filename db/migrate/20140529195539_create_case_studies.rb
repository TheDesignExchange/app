class CreateCaseStudies < ActiveRecord::Migration

@@cs_attributes = ["mainImage", "title", "companyName", "developmentCycle", "designPhase", "projectDomain", "customerIsUser", "remoteProject", "customerType", "userAge", "privacyLevel", "socialSetting", "description", "methods", "authorName", "authorEmail", "authorOther", "permissionToUse", "imageResource", "PDFResource", "url", "timePeriod"] 	
  def change
    create_table :case_studies do |t|
      @@cs_attributes.each do |x|
      	t.string x.to_sym,  :default => ""
      end
      t.timestamps
    end
  end
end
