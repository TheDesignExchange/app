require 'test_helper'

class FeedbacksSubmissionTest < ActionDispatch::IntegrationTest

  test "invalid submission" do
    get feedback_path
    assert_no_difference 'Feedback.count' do
      post feedbacks_path, feedback: { title:  "",
                               email: "user@invalid",
                               type:              "foo",
                               body: "bar" }
    end
    assert_template 'feedbacks/new'
  end
end
