module DeHelper
	def thumbnail(obj)
		thumb_obj = {}
		if obj.is_a?(DesignMethod)
			thumb_obj=	
				{
					:url => "http://web.mit.edu/2.009/www/resources/illustrator/crash-course/productstoryboardex.jpg",
					:name => obj.name.humanize,
					:tags => obj.method_categories.map{|x| x.name}[0..1],
					:likes => (rand*100).to_i,
					:description => obj.overview,
					:id => obj.id,
					:link => "/methods/view"	
				}
		elsif obj.is_a?(CaseStudy)
			thumb_obj=	
				{
					:url => "http://web.mit.edu/2.009/www/resources/illustrator/crash-course/productstoryboardex.jpg",
					:name => obj.title,
					:tags => [],
					:likes => (rand*100).to_i,
					:description => obj.description,
					:id => obj.id,
					:link => "/case_studies/view"	
				}
		elsif obj.is_a?(Discussion)
			thumb_obj=	
				{
					:url => "http://web.mit.edu/2.009/www/resources/illustrator/crash-course/productstoryboardex.jpg",
					:name => obj.title,
					:tags => [],
					:likes => (rand*100).to_i,
					:description => obj.description,
					:id => obj.id,
					:link => "/discussions/view"	
				}
		end
		return thumb_obj
	end

	def tagifier(obj)
		category_array = []
		obj.map do |x|
		  	category = x.split("_")
		  	if category[1] then category[1] = category[1].humanize end
		  	category = category.join(' ');
		 	#category = category.underscore().dasherize
		 	category_array.push(category)
		end
		return category_array
	end

end