require 'rails_helper'

RSpec.describe "posts/show", :type => :view do
  before(:each) do
    @post = assign(:post, Post.create!(
      :template_name => "Template Name",
      :title => "Title",
      :body => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Template Name/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
