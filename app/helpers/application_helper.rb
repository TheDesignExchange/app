module ApplicationHelper

	@@methods_file = "method_categories.json"

	def sidebar_hash(symbol)

		method_categories = MethodCategory.all
		method_hash = {}

		method_categories.each do |c|
			method_hash[c.name] = [{"All (#{c.design_methods.length})" =>  []}]
		end

		if symbol == :methods
			# file = Rails.root.join('public', @@methods_file);
			# data = JSON.parse( IO.read(file) )
			data = method_hash
		elsif symbol == :case_studies
			# return case_studies
		end
		return data
	end


	def human_boolean(boolean)
	    boolean ? 'Yes' : 'No'
	end

	def tagify(id, content, options)
		fn = options[:method] ? "removeMethodLink" : "removeTag"
		tag = "<span class='tag-label label-gap'>#{content}  " 
	    if options[:removable]
	    	tag = tag + '<span onclick="'+ fn +'('+ (id.to_s) +', this);" class="glyphicon glyphicon-remove-circle"></span>' 
	    end
	    tag = tag + '</span>'
		tag.html_safe
	end

	def md_format(text)
		::Kramdown::Document.new(text, input: 'GFM').to_html.html_safe
	end

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
						<a class='category-heading sidebar-maincategory' href=''> #{key} </a>
						<ul class='collapse sidebar-element'> 
							#{options}
						</ul>
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

	# CONVERTS OBJECTS TO THE LAYOUT/THUMBNAIL PARTIAL
	def thumbnail(obj,col_md_value, word_count = 300)
		thumb_obj = {}
		if obj.is_a?(DesignMethod)
			thumb_obj=	
				{
					:image => obj.main_image,
					:name => obj.name,
					:tags => obj.tags.map{|t| t.content},
					:likes => obj.likes,
					:overview => obj.overview,
					:id => obj.id,
					:link => "design_method",
					:col_md_value => col_md_value, 
					:word_count => word_count	
				}
		elsif obj.is_a?(CaseStudy)
			thumb_obj=	
				{
					:image => obj.main_image,
					:name => obj.name,
					:tags => obj.tags.map{|t| t.content},
					:likes => (rand*100).to_i,
					:overview => obj.overview,
					:id => obj.id,
					:link => "case_study",
					:col_md_value => col_md_value, 
					:word_count => word_count		
				}
		elsif obj.is_a?(Discussion)
			thumb_obj=	
				{
					:image => nil,
					:name => obj.name,
					:tags => [],
					:likes => (rand*100).to_i,
					:description => obj.description,
					:id => obj.id,
					:link => "discussion",
					:col_md_value => col_md_value, 
					:word_count => word_count	
				}
		end
		return thumb_obj
	end

	def tagifier(obj)
		category_array = obj
		# obj.map do |x|
		#   	category = x.split("_")
		#   	if category[1] then category[1] = category[1].humanize end
		#   	category = category.join(' ');
		#  	#category = category.underscore().dasherize
		#  	category_array.push(category)
		# end
		return category_array
	end

	def glyphyify(value)
	   content_tag(:span, "", :class => "glyphicon glyphicon-#{value}")
	end

end

