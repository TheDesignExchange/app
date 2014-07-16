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

end

