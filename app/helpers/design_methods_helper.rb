module DesignMethodsHelper
	def glyphyify(value)
	   content_tag(:span, "", :class => "glyphicon glyphicon-#{value}")
	end
end
