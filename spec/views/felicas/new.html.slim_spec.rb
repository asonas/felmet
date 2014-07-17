require 'rails_helper'

RSpec.describe "felicas/new", :type => :view do
  before(:each) do
    assign(:felica, Felica.new(
      :idm => "MyString",
      :activation => false
    ))
  end

  it "renders new felica form" do
    render

    assert_select "form[action=?][method=?]", felicas_path, "post" do

      assert_select "input#felica_idm[name=?]", "felica[idm]"

      assert_select "input#felica_activation[name=?]", "felica[activation]"
    end
  end
end
