require 'rails_helper'

RSpec.describe "tags/new", :type => :view do
  before(:each) do
    assign(:tag, Tag.new(
      :design_method_id => 1,
      :case_study_id => 1,
      :discussion_id => 1,
      :user_id => 1,
      :content => "MyString"
    ))
  end

  it "renders new tag form" do
    render

    assert_select "form[action=?][method=?]", tags_path, "post" do

      assert_select "input#tag_design_method_id[name=?]", "tag[design_method_id]"

      assert_select "input#tag_case_study_id[name=?]", "tag[case_study_id]"

      assert_select "input#tag_discussion_id[name=?]", "tag[discussion_id]"

      assert_select "input#tag_user_id[name=?]", "tag[user_id]"

      assert_select "input#tag_content[name=?]", "tag[content]"
    end
  end
end
