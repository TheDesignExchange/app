require "json"

p "Adding case studies"
casestudy_file = Rails.root.join('public', 'casestudies.json');
data = JSON.parse( IO.read(casestudy_file) )

data.each do |el|
	el.delete("companyID")
	c = CaseStudy.new(el)
	p c.title
	c.save
end
