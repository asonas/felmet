require 'rails_helper'

RSpec.describe "felicas/index", :type => :view do
  before(:each) do
    assign(:felicas, [
      Felica.create!(
        :idm => "Idm",
        :activation => false
      ),
      Felica.create!(
        :idm => "Idm",
        :activation => false
      )
    ])
  end

  it "renders a list of felicas" do
    render
    assert_select "tr>td", :text => "Idm".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
