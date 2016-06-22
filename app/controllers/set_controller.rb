class SetController < ApplicationController
  load_and_authorize_resource

  def index
  	render :layout => "wide"
  end
end
