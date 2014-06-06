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
		comp = Company.new({:name => raw["companyName"], :domain => raw["projectDomain"]})
		comp.save
		p comp.name
	end

	

	raw.delete("companyName")
	raw.delete("projectDomain")
	raw.delete("authorName")
	raw.delete("authorEmail")
	raw.delete("authorOther")
	
	c = CaseStudy.new(raw)
	c.company = comp
	p c.title
	c.save

end
