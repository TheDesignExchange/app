class DiscussionsController < ApplicationController
  def home
  	render layout: "custom"
  end

  def create
    render layout: "custom"
  end

  def view
  	render layout: "wide"
  end

  def search
  end
end
