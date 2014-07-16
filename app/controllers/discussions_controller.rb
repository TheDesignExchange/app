class DiscussionsController < ApplicationController
  def index
    @discussions = Discussion.take(20)
  	render layout: "custom"
  end

  def new
    render layout: "custom"
  end

  def show
    id = params['n'].to_i
    disc = Discussion.find(id)
    @discussion = disc
    @author = disc.user.email
  	render layout: "custom"
  end
end
