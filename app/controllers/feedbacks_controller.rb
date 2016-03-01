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
  
  def index
    @feedbacks = Feedback.all
  end
  
  def edit
    @feedback = Feedback.find(params[:id])
  end
  
  def update
    @feedback = Feedback.find(params[:id])
    if @feedback.update_attributes(feedback_params)
      @feedback.save
      redirect_to feedbacks_path
    else
      render 'new'
    end
  end
  
  
  private

    def feedback_params
      params.require(:feedback).permit(:title, :email, :feedbacktype, :body, :status)
    end
end
