require 'rails_helper'

RSpec.describe "tags/index", :type => :view do
  before(:each) do
    assign(:tags, [
      Tag.create!(
        :design_method_id => 1,
        :case_study_id => 2,
        :discussion_id => 3,
        :user_id => 4,
        :content => "Content"
      ),
      Tag.create!(
        :design_method_id => 1,
        :case_study_id => 2,
        :discussion_id => 3,
        :user_id => 4,
        :content => "Content"
      )
    ])
  end

  it "renders a list of tags" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => "Content".to_s, :count => 2
  end
end
