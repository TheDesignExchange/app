class CreateCaseStudies < ActiveRecord::Migration
@@file_attributes = ["permissionToUse", "name", "type"]

@@company_attributes = ["companyName", "contact"]
@@model_attribtues = ["developmentCycle", "designPhase", "projectDomain", "customerType", "userAge", "privacyLevel", "socialSetting"]

@@cs_attributes = ["mainImage", "title", "description", "methods", "url", "timePeriod"] 	
@@cs_bool_attributes = ["customerIsUser", "remoteProject"]

  def change
    create_table :case_studies do |t|
      @@cs_attributes.each do |x|
      	t.string x.to_sym,  :default => ""
      end

      # Active Record - Rails - Migrations - Types - Specific values - Dropdown
       # t.longstring "description"
       # t.longstring "timeperiod"
       # t.longstring "url"
       # t.integer  "developmentCyle" ["Production", "", ...]

      @@cs_bool_attributes.each do |x|
      	t.boolean x.to_sym,  :default => false
      end
      t.integer :company_id
      t.timestamps
    end
  end
end
