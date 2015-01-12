class AddFeedbacktypeToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :feedbacktype, :string
  end
end
