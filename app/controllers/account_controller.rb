class AccountController < ApplicationController
  def profile_user
  end

  def settings
  end

  def login
  	render layout: "custom" 
  end

  def register
<<<<<<< HEAD
  	render layout: "custom" 
=======
  	@user = CaseStudy.new
  	render layout: "custom"
>>>>>>> FETCH_HEAD
  end
end
