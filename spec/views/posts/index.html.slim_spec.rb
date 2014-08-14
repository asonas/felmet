require 'rails_helper'

RSpec.describe "posts/index", :type => :view do
  before(:each) do
    assign(:posts, [
      Post.create!(
        :template_name => "Template Name",
        :title => "Title",
        :body => "MyText"
      ),
      Post.create!(
        :template_name => "Template Name",
        :title => "Title",
        :body => "MyText"
      )
    ])
  end

  it "renders a list of posts" do
    render
    assert_select "tr>td", :text => "Template Name".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
