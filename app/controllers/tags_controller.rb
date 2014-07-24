class TagsController < InheritedResources::Base
	def create
    @tag = Tag.new(params[:tag])

   
      if @tag.save
        # format.html { redirect_to @tag, notice: 'Design method was successfully created.' }
        # format.json { render json: @tag, status: :created, location: @tag }
        render :json => {:tag => tagify(@tag.content, {:removable => true})}
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    
  end
  def tagify(id, content, options)
    tag = "<span class='tag-label label-gap'>#{content}  " 
      if options[:removable]
        tag = tag + '<span onclick="removeTag('+ (id.to_s) +', this);" class="glyphicon glyphicon-remove-circle"></span>' 
      end
      tag = tag + '</span>'
    tag.html_safe
  end
end
