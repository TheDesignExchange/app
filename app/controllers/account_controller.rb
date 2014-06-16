class AccountController < ApplicationController
  def profile_user
  end

  def settings
  end

  def login 
  end

  def register
  	@user = CaseStudy.new
  	render layout: "custom"
  end
end
