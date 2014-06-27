module DeHelper
	def thumbnail(obj)

		if obj.is_a?(DesignMethod)
			url = "http://web.mit.edu/2.009/www/resources/illustrator/crash-course/productstoryboardex.jpg"
			name = obj.name.humanize
			tags = obj.method_categories.map{|x| x.name}[0..1]
			likes = (rand*100).to_i
			description = obj.overview
			id = obj.id
			link = "/methods/view"
		elsif obj.is_a?(CaseStudy)
			url = "http://web.mit.edu/2.009/www/resources/illustrator/crash-course/productstoryboardex.jpg" 
			name = obj.title 
			tags = [] 
			likes = (rand * 100).to_i 
			description = obj.description 
			id = obj.id 
			link = "/case_studies/view"
		end

		str = "<div class='col-sm-6 col-md-3 left-top-padding'>
   			<div class='thumbnail search-item'>
  		   		<div class='caption'>
  		     		<h5>"+
  		(link_to "#{name}", "#{link}?n=#{id}" )+ 
  		"</h5><p><span class='glyphicon glyphicon-star'></span> #{likes} Likes</p>
  		     		<p class='truncate-multiline'> #{description}</p>"+ 
  		     		tagifier(tags)+
  		   		"</div>
  	  		</div>
  		</div>"
  		str.html_safe
	end

	def tagifier(obj)
		str = obj.map do |x|
		  	category = x.split("_")
		  	if category[1] then category[1] = category[1].humanize end
		  	category = category.join(' ');
		 	#category = category.underscore().dasherize
				"<span class='tag-label label-gap'>#{category}</span>"
		end
		"<p>"+str.join('')+"</p>"
	end
end