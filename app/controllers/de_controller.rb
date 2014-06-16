class DeController < ApplicationController

  def index
  	render layout: "custom"
  	@user = User.new
  end

  def search
  	render layout: "wide"
  end

  # <button oasdhfkljahsd;fh onclick="location.href = '/de/index'; "> 
end
