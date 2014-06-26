module DiscussionsHelper
	def discussions(obj)

		str = 	"<div class='row no-margin-left no-margin-right'>
					<div class='col-md-1'>
						<h2 align='center'>#{obj[:likes]}</h2>
						<p align='center'>likes</p>
					</div>
  					<div class='col-md-11'>
  						<a class='font-discussion-tittle'>#{obj[:title]}</a> #{obj[:time]} ago <a>#{obj[:name]}</a>
  						<p>#{obj[:responses]} response</p>"+tagifier(obj[:tags])+"
  					</div>
  					<div class='col-md-12'>
  						<hr>
  					</div>
				</div>"

			str.html_safe
	end
end