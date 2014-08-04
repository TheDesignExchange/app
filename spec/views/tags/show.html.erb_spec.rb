require 'rails_helper'

RSpec.describe "tags/show", :type => :view do
  before(:each) do
    @tag = assign(:tag, Tag.create!(
      :design_method_id => 1,
      :case_study_id => 2,
      :discussion_id => 3,
      :user_id => 4,
      :content => "Content"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/Content/)
  end
end
