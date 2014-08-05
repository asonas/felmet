require 'rails_helper'

RSpec.describe "events/index", :type => :view do
  before(:each) do
    assign(:events, [
      Event.create!(
        :user => nil
      ),
      Event.create!(
        :user => nil
      )
    ])
  end

  it "renders a list of events" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
