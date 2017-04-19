build_names = ["Mock-up", "Operational Prototype", "Production", "High", "Medium", "Low", "Product", "Service", "Either",
				"Physical offering", "Digital offering", "Either", "Abstract", "Tangible", "Virtual", "Behavior", "Role/context", "Appearance", 
				"Implementation", "Horizontal slice", "Vertical slice", "Full scope"]
build_descripions = [
	"Phase of prototyping where prototypes are not fully functional.", 
	"Prototype has the look and functionality of the final design",  
	"Ready to be produced", 
	"Realistic prototype of look and function",
	"Semi-complete prototype of final product",
	"They're easy to create, inexpensive to change, and are good for providing a basic mockup",
	"Product existing in physical/digital mediums", 
	"Service existing in physical/digital mediums",
	"Product/Service existing in physical/digital mediums",
	"Product/Service existing in the physical mediums",
	"Product/Service existing in the digital mediums",
	"Product/Service existing in the digital/physical mediums",
	"Enhances understanding of what it might be like to use the product/service/etc.",
	"Prototype using tangible mediums",
	"Prototype using digital mediums",
	"Explores product's behavior and response",
	"Explores product's role in the larger use context",
	"Explores product's visual appearance",
	"Explore one level of the design, but with limited depth",
	"Explore one aspect of the design in depth",
	"Explore the full design"
	]

for i in 0..build_names.count
	char = MethodCategory.find_by(name:"Build").characteristics.find_by(name:build_names[i])
	if char == nil
		puts build_names[i]
	end
	char.description = build_descripions[i]
	char.save
end