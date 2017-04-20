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
	"Explores the technical implementation of the product's function",
	"Explore one level of the design, but with limited depth",
	"Explore one aspect of the design in depth",
	"Explore the full design"
	]

for i in 0..build_names.count-1
	char = MethodCategory.find_by(name:"Build").characteristics.find_by(name:build_names[i])
	puts build_names[i]
	char.description = build_descripions[i]
	char.save
end

analyze_names = ["Observations/images", "Themes", "Concepts", "Insights", "Quantitative data", "Text/quotes", "Observations",
				"Charts", "Imperatives", "Network diagrams", "Themes", "Perspective shifts", "Rankings", "Flowcharts", "Hierarchies",
				"Matrices", "Timelines/trends", "Venn diagrams", "Long-term","Short-term","Either",	"Past trends", "Present situation",
						"Future possibilities"]
analyze_descriptions = ["methods take in or process visual materials",
						"methods that start with themes, dimensions, or groups",
						"",
						"",
						"",
						"methods take in or process text",
						"",
						"",
						"methods that create node-link diagrams",
						"",
						"methods that start with themes, dimensions, or groups",
						"methods help shift perspectives",
						"",
						"methods that produce flowcharts",
						"methods that help create/identify hierarchy or trees",
						"",
						"methods that produce timelines",
						"overlapping clusters or concepts",
						"Methods appropriate for collecting immediate impressions, insights, surprises, etc.",
						"Methods appropriate for digging deep into the data to look for patterns, etc.",
						"Methods appropriate for both collecting immediate impressions, insights, surprises, etc and for digging deep into the data to look for patterns, etc",
						"Methods meant to explore the past.",
						"Methods meant to explore the present.",
						"Methods meant to reveal future opportunities."
						]
for i in 0..analyze_names.count-1
	char = MethodCategory.find_by(name:"Analyze").characteristics.find_by(name:analyze_names[i])
	puts analyze_names[i]
	char.description = analyze_descriptions[i]
	char.save
end

ideate_names = ["Writing", "Talking", "Drawing", "Deciding", "Building", "System level", "Product level", "Feature level", "Core team",
				"Relevant stakeholders", "Individual", "Users (co-design)", "Small", "Individual", "Medium", "Large", "Simple",
				"Average", "Complex", "Quick meeting", "Normal meeting", "Multi-day", "On-going", "Half day"]
ideate_descriptions = ["Using creative methods to indirectly develop ideas", 
						"Methods to stimulate conversations between group members (indirect ideation)", 
						"", 
						"",
						"",
						"good for coming up with new business models, product-ecosystems, etc.",
						"good for coming up with new products or services",
						"good for coming up with new features",
						"designers and design researchers only",
						"members of company outside design/reserach team",
						"Solo activities",
						"members of potential customer and/or user groups",
						"2 to 8 participants",
						"Solo activities",
						"8 to 25",
						"25-50",
						"2-3 steps",
						"4-8 steps",
						"9+ steps",
						"30 min or less",
						"1-2 hours",
						"sessions over multiple days",
						"continuous collection, less structured/set methods",
						"4 hours"
						]

for i in 0..ideate_names.count-1
	char = MethodCategory.find_by(name:"Ideate").characteristics.find_by(name:ideate_names[i])
	puts ideate_names[i]
	char.description = ideate_descriptions[i]
	char.save
end

communicate_names = [ "Core team", "Core team + immediate collaborators", 
					"Full team", "Users", "Mass", "No persuasion", "Low", "Medium", "Little", "Some", "A lot"]
communicate_descriptions = [ "Research and/or design team - those working directly on the work being presented ",
							 "Larger working team + decision makers (i.e., people who might give immediate feedback to the core team)",
							 "Organization at large (everyone involved even remotely in the design)",
							"Users",
							"Mass market, media, etc.",
							"audience assumptions are only being confirmed/These methods are not good for persuading the audience to a new perspective",
							"methods for when some minor assumptions are being broken, but most are being confirmed",
							"methods for when a major assumption is being broken",
							"Presenter and audience have a close relationship and the topic is non-threatening/non-sensitive",
							"Presenter and audience do not have a close relationship and the topic is non-threatening/non-sensitive",
							"Presenter and audience do not have a close relationship and the topic is threatening or sensitive"]
for i in 0..communicate_names.count-1
	char = MethodCategory.find_by(name:"Communicate").characteristics.find_by(name:communicate_names[i])
	puts communicate_names[i]
	char.description = communicate_descriptions[i]
	char.save
end