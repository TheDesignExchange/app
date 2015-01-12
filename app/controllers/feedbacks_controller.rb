class FeedbacksController < ApplicationController
  def show
    @feedback = Feedback.find(params[:id])
  end
  
  def new
    @feedback = Feedback.new
  end
end
