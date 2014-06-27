class AccountController < ApplicationController
  def profile_user
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
end
