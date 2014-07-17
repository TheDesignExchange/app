module DeHelper

	def print_children(level,h)
		str=""
  		h.each_pair do |k,v|

  			# Leaf Case
    		if v.empty?
    			str = leaf (k)
    		# Header Case
    		else
    			str1 = ""
    			v.each do |h|
    				str1 = str1 + print_children(level+1,h)
    			end
    			str = str + header(k, str1,level)
    		end
  		end
  		return str
	end

	def header (key, options, level)
		str = ""
		# Main Category's  font is bold and  it is collapsed
		if level == 0
			str = "<ul class='sidebar-element'>
						<div class='category' >
						<a class='category-heading sidebar-maincategory'> #{key} </a>
							<ul class='collapse sidebar-element'>"+
							options + 
						"</ul>
					</div>
		   		   </ul>"
		# Headers level 2 and more are collapsed
		elsif level >= 2
			str = "<ul class='sidebar-element'>
  					<div class='category' >
    					<a class='category-heading'> #{key} </a>
    						<ul class='collapse sidebar-element'>"+
    							options + 
    						"</ul>
    				</div>
    			   </ul>"
    	else
    		str = "<ul class='sidebar-element'>
  					<div class='category' >
    					<a class='category-heading'> #{key} </a>
    						<ul class='collapse sidebar-element in'>"+
    							options + 
    						"</ul>
    				</div>
    			   </ul>"
    	end

    	return str
    end

	def leaf (key)
		return "<label class='sidebar-leaf'>
                	<input type='checkbox'> #{key}
                </label>"
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
					:link => "design_method",
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
					:link => "case_study",
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
					:link => "discussion",
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