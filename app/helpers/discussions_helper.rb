module DiscussionsHelper
	def discussions(obj)

		str = 	"<div class='row row-margin'>
					<div class='col-md-1'>
						<h2 align='center'>#{obj[:likes]}</h2>
						<p align='center'>likes</p>
				</div>
  				<div class='col-md-11'>
  					<a class='font-discussion-tittle'>#{obj[:title]}</a> #{obj[:time]} ago <a>#{obj[:name]}</a>
  					<p>#{obj[:responses]} response</p>"+
  					tagifier(obj[:tags])+
  				"</div>
			</div>
			<hr class='hr-margin'>"

			str.html_safe
	end

	def tagifier(obj)
		str = obj.map do |x|
			category = x.split(" ")
			if category[1] then category[1] = category[1].humanize end
			category = category.join('');
		category = category.underscore().dasherize
				"<span class='label label-gap label-#{category}'>#{x}</span>"
		end
		"<p>"+str.join('')+"</p>"
	end
end