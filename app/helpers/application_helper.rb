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

end

