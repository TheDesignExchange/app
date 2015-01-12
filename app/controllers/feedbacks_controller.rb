class FeedbacksController < ApplicationController
  def show
    @feedback = Feedback.find(params[:id])
  end
  
  def new
    @feedback = Feedback.new
  end
  
  def create
    @feedback = Feedback.new(feedback_params)
    if @feedback.save
      flash[:success] = "Thank you for the feedback!"
      redirect_to feedback_path(@feedback)
    else
      render 'new'
    end
  end
  
  
  private

    def feedback_params
      params.require(:feedback).permit(:title, :email, :type, :body)
    end
end
