class CreateCaseStudies < ActiveRecord::Migration
@@file_attributes = ["permissionToUse", "name", "type"]

@@model_attribtues = ["developmentCycle", "designPhase", "projectDomain", "customerType", "userAge", "privacyLevel", "socialSetting"]

@@cs_attributes = ["mainImage", "title", "methods", "url", "timePeriod"] 	
@@cs_bool_attributes = ["customerIsUser", "remoteProject"]

  def change
    create_table :case_studies do |t|
      @@cs_attributes.each do |x|
      	t.string x.to_sym,  :default => ""

      end
      t.integer :development_cycle, :design_phase, :project_domain, :customer_type, :user_age, :privacy_level, :social_setting
      t.text :description

      @@cs_bool_attributes.each do |x|
      	t.boolean x.to_sym,  :default => false
      end
      t.integer :company_id
      t.timestamps
    end
  end
end
