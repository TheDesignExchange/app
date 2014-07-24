require 'similarity'

module ApplicationHelper

	@@methods_file = "method_categories.json"

	def sidebar_hash(symbol)
		if symbol == :methods
			file = Rails.root.join('public', @@methods_file);
			data = JSON.parse( IO.read(file) )
		elsif symbol == :case_studies
			# return case_studies
		end
		return data
	end


	def human_boolean(boolean)
	    boolean ? 'Yes' : 'No'
	end

	def tagify(content)
		# tag << eos 
		# 	<span class="tag-label label-gap">brainstorming 
	 #         <span class="glyphicon glyphicon-remove-circle"></span>
	 #        </span>
  #       eos
  		tag = content
        tag.html_safe
	end

end

