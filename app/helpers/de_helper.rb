module DeHelper

	def print_children(level,h)
		str=""
  		h.each_pair do |k,v|

  			# Leaf Case
    		if v.empty?
    			str = leaf (k)
    		else
    			#Collapsed Headers
    			if level == 0 || level >= 2
    				#print subcategories
    				str1 = ""
    				v.each do |h|
    					str1 = str1 + print_children(level+1,h)
    				end
    				str = str + collapsed_header(k, str1)
    			#Not-collapsed Headers
    			else
    				#print subcatefories and/or leaves
    				str1=""
    				v.each do |h|
	          			str1=str1+print_children(level+1,h)
	          		end  
    				str = str + header(k, str1)
   				end
    		end
  		end
  		return str
	end

	def header (key, options)
		return "<ul class='sidebar-element'>
  					<div class='category' >
    					<a class='category-heading'> #{key} </a>
    						<ul class='collapse sidebar-element in'>"+
    							options + 
    						"</ul>
    				</div>
    			</ul>"
	end

	def collapsed_header (key, options)
		return "<ul class='sidebar-element'>
  					<div class='category' >
    					<a class='category-heading'> #{key} </a>
    						<ul class='collapse sidebar-element'>"+
    							options + 
    						"</ul>
    				</div>
    			</ul>"
	end

	def leaf (key)
		return "<div class='checkbox'>
              		<label>
                		<input type='checkbox'> #{key}
                	</label>
            	</div>"
	end

	def thumbnail(obj,col_md_value)
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
					:link => "/methods/view",
					:col_md_value => col_md_value	
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
					:link => "/case_studies/view",
					:col_md_value => col_md_value		
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
					:link => "/discussions/view",
					:col_md_value => col_md_value	
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