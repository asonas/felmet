require 'rails_helper'

RSpec.describe "users/edit", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :felica => "",
      :name => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_felica[name=?]", "user[felica]"

      assert_select "input#user_name[name=?]", "user[name]"
    end
  end
end
