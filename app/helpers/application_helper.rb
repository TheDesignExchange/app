class String
  def upcase_first
    output = dup
    return output if output[0].nil?
    output[0] = output[0].capitalize
		output
  end
end

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
    extra_class = options[:class] ? " #{options[:class]}" : ""
    classes = "tag-label label-gap#{extra_class}"
		tag = "<span class='#{classes}'>#{content}"
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

  # Format a list of design_methods for front-end convenience
  def format_design_methods(design_methods)

  end

  # Return a nested list of categories, characteristic characteristics, and characteristics that belong to
  # a set of design_methods. Used for filtering search results.
  #
  # The output should be in this format:
  # [
  #   { "id": 1,
  #     "name": "Build",
  #     "characteristic_characteristics": [
  #       { "id": 1,
  #         "name": "Fidelity",
  #         "characteristics": [
  #           { "id": 1,
  #             "name": "Low"
  #           },
  #           ...
  #         ]
  #       },
  #       ...
  #     ]
  #   },
  #   ...
  # ]
  def get_filters(design_methods)

    filters = {}

    # start by creating hashes that map IDs to the formatted hash of the filter, i.e.
    # { <category_id_1>: <formatted_category_hash_1>, <category_id_2>: <formatted_category_hash_2>, ...}
    # and the same for characteristic groups and characteristics
    #
    # later we flatten these hashes down to lists by calling hash.values
    design_methods.each do |design_method|
      design_method.characteristics.each do |characteristic|


        group = characteristic.characteristic_group
        category = characteristic.characteristic_group.method_category

        # add category if it does not exist
        if not filters.keys.include? category.id
          formatted_category = {}

          formatted_category[:id] = category.id
          formatted_category[:name] = category.name
          formatted_category[:characteristic_groups] = {}

          filters[category.id] = formatted_category
        end

        # add group if it does not exist
        if not filters[category.id][:characteristic_groups].keys.include? group.id
          formatted_group = {}

          formatted_group[:id] = group.id
          formatted_group[:name] = group.name
          formatted_group[:characteristics] = {}

          filters[category.id][:characteristic_groups][group.id] = formatted_group
        end

        # add characteristic if it does not exist
        if not filters[category.id][:characteristic_groups] \
          [group.id][:characteristics].keys.include? characteristic.id

          formatted_characteristic = {}

          formatted_characteristic[:id] = characteristic.id
          formatted_characteristic[:name] = characteristic.name

          filters[category.id][:characteristic_groups] \
            [group.id][:characteristics][characteristic.id] = formatted_characteristic
        end
      end
    end

    # flatten down hashes into lists
    filters.values.each do |category|
      category[:characteristic_groups].values.each do |groups|
        groups[:characteristics] = groups[:characteristics].values
      end
      category[:characteristic_groups] = category[:characteristic_groups].values
    end
    filters = filters.values

    return filters
  end

end
