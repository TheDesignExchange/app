require 'test_helper'

class FeedbacksControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "successful post" do

	  post :create, message: {
	    name: 'jenny',
	    email: 'jenny@example.com',
	    subject: 'hi',
	    content: 'bai'
	  }

	  assert_redirected_to new_message_path
	end

	test "failed post" do
	  post :create, message: {\
	    name: '',
	    email: '',
	    subject: '',
	    content: ''
	  }

	  [:name, :email, :subject, :content].each do |attr|
	    assert_select 'li', "#{attr.capitalize} can't be blank"
	  end
	end
end