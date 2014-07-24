require "json"


case_study_file = 'casestudies.json'

# File should be in public
def get_data(json_file)
	file = Rails.root.join('public', json_file);
	data = JSON.parse( IO.read(file) )
end

def process_companies(data)
	Company.destroy_all
	p "===============  SEEDING COMPANIES  ================"
	data.each do |el|
		el["projectDomain"] ||= "design"
		temp_email = "#{el['companyName'].gsub(' ','').downcase.gsub('&', '')}@unknown.com"
		comp = Company.new({:name => el["companyName"], :domain => el["projectDomain"], :email => temp_email })
		p "Added company: #{comp.name}" unless not comp.save 
		# p comp.errors unless comp.save
	end
	p "==============================="
end
def process_contacts(data)
	
	p "===============  SEEDING CONTACT  ================"
	Contact.destroy_all
	data.each do |el|
	  	if el["authorName"]
	 		id = Company.where("name = ?", el["companyName"]).first.id
	 		ct = Contact.new({:name => el["authorName"].split(',')[0], :email => el["authorEmail"], :company_id => id})
			p "Added contact: #{ct.name}" unless not ct.save
			# p ct.errors unless ct.save
		end 
	end
	
	p "==============================="
end
def process_casestudies(data)
	CaseStudy.destroy_all
	p "===============  SEEDING CASE STUDIES  ================"
	data.each do |el|
		el.each{|k, v| el[k] = v.strip }
		comp = Company.where("name = ?", el["companyName"]).first
		el.delete("companyName")
		el.delete("projectDomain")
		el.delete("authorName")
		el.delete("authorEmail")
		el.delete("authorOther")
		el.delete("methods")
		
		c = CaseStudy.new(el)
		c.company = comp
		p "Added casestudy: #{c.title}" unless not c.save
		p c.errors unless c.save
		
	end
	p "==============================="
end

def clean_raw_data(data)
	data.each do |raw|
		@@deletions.each do |d|
			d.each do |el|
				raw.delete(el)
			end
		end
	end
	data
end




file_attributes = ["permissionToUse", "name", "type"]
author_attributes = ["authorName", "authorEmail", "authorOther"]
company_attributes = ["contact"]
model_attribtues = ["developmentCycle", "designPhase", "customerType", "userAge", "privacyLevel", "socialSetting"]
other = ["companyID", "subTitle", "imageResource", "PDFResource"]
@@deletions = [other, file_attributes, company_attributes, model_attribtues]

data = get_data(case_study_file)
clean_data = clean_raw_data(data)
process_companies(clean_data)
process_contacts(data)
process_casestudies(data)

	

	
		
	



	
	
	


