class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
    render :layout => "custom"
  end

  def create
    @feedback = Feedback.new(feedback_params)

    if !verify_recaptcha(model: @feedback, message: "Error: Please try again and verify that you are not a robot")
      redirect_to(:back)

    elsif @feedback.valid?
      FeedbackMailer.message_me(@feedback).deliver
      redirect_to(:back)
      flash[:success] = "Thank you for your feedback! Your message has been sent successfully."

    else
      redirect_to(:back)
      flash[:danger] = "Error: "
      @feedback.errors.full_messages.each do |msg|
        flash[:danger] += msg
      end

    end
  end
  private

  def feedback_params
    params.require(:feedback).permit(:name, :email, :subject, :content)
  end
end
