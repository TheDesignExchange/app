require "json"

p "Adding case studies"
casestudy_file = Rails.root.join('public', 'casestudies.json');
data = JSON.parse( IO.read(casestudy_file) )

file_attributes = ["permissionToUse", "name", "type"]
author_attributes = ["authorName", "authorEmail", "authorOther"]
company_attributes = ["contact"]
model_attribtues = ["developmentCycle", "designPhase", "customerType", "userAge", "privacyLevel", "socialSetting"]
other = ["companyID", "subTitle", "imageResource", "PDFResource"]

deletions = [other, file_attributes, company_attributes, model_attribtues]
data.each do |raw|

	deletions.each do |d|
		d.each do |el|
			raw.delete(el)
		end
	end 
	comp = Company.where("name = ?", raw["companyName"]).first
	p raw["companyName"]
	p raw["projectDomain"]


	if(comp == nil)
		if raw["authorName"]
			comp = Company.new({:name => raw["companyName"], :domain => raw["projectDomain"]})
		else
			comp = Company.new({:name => raw["companyName"], :domain => raw["projectDomain"], :email =>raw["authorEmail"]})
		end
		comp.save
		p comp.name
	end

	# class CreateContacts < ActiveRecord::Migration
 #  def change
 #    create_table :contacts do |t|
 #      t.string :name,  :default => ""
 #      t.string :email,  :default => ""
 #      t.string :phone, :default => ""
 #      t.integer :company_id
 #      t.timestamps
 #    end
 #  end
  	if raw["authorName"]
 		id = Company.where("name = ?", raw["companyName"]).first.id
 		ct = Contact.new({:name => raw["authorName"].split(',')[0], :email => raw["authorEmail"], :company_id => id})
		ct.save
	end 

	raw.delete("companyName")
	raw.delete("projectDomain")
	raw.delete("authorName")
	raw.delete("authorEmail")
	raw.delete("authorOther")
	
	raw.each{|k, v| raw[k] = v.trim }

	c = CaseStudy.new(raw)
	c.company = comp
	p c.title

	p c.save

end
