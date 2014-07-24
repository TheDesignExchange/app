class AccountController < ApplicationController
  def profile_user
    id = params["n"] == nil ? 1 : params["n"].to_i
    # render :text => id
    @user = User.where("id=?", id).first;

    render layout: "wide"
  end

  def profile_user_edit
    render layout: "wide"
  end

  def account_information
    render layout: "custom"
  end

  def login
  	render layout: "custom" 
  end

  def register
  	render layout: "custom" 
  end

  def tagify(content, options)
    tag = "<span class='tag-label label-gap'>#{content}  " 
      if options[:removable]
        tag = tag + '<span class="glyphicon glyphicon-remove-circle"></span>' 
      end
      tag = tag + '</span>'
    tag.html_safe
  end
end
