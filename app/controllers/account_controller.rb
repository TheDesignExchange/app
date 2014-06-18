class AccountController < ApplicationController
  def profile_user
  end

  def settings
  end

  def login
  	render layout: "custom" 
  end

  def register
  	render layout: "custom" 
  end
end
