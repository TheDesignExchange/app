class DiscussionsController < ApplicationController
  def home
    @discussions = Discussion.take(20)
  	render layout: "custom"
  end

  def create
    render layout: "custom"
  end

  def view
    id = params['n'].to_i
    disc = Discussion.find(id)
    @discussion = disc
    @author = disc.user.email
  	render layout: "custom"
  end

  def search
  end
end
