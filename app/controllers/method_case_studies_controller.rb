class MethodCaseStudiesController < ApplicationController
   def create
    @mcs = MethodCaseStudy.new(params[:tag])   
      if @mcs.save
        # format.html { redirect_to @tag, notice: 'Design method was successfully created.' }
        # format.json { render json: @tag, status: :created, location: @tag }
        render :json => {:mcs => mcs(@mcs.id, @mcs.design_method.name, {:removable => true})}
      else
        # format.html { render action: "new" }
        render json: @mcs.errors, status: :unprocessable_entity
    end
    
  end
  def mcs(id, content, options)
    tag = "<span class='tag-label label-gap'>#{content}  " 
      if options[:removable]
        tag = tag + '<span onclick="removeMethodLink('+ (id.to_s) +', this);" class="glyphicon glyphicon-remove-circle"></span>' 
      end
      tag = tag + '</span>'
    tag.html_safe
  end
  def destroy
    @mcs = MethodCaseStudy.find(params[:id])
    @mcs.destroy

    respond_to do |format|
      format.html { head :no_content }
      format.json { head :no_content }
    end
  end
end
