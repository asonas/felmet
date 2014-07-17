require 'rails_helper'

RSpec.describe "felicas/edit", :type => :view do
  before(:each) do
    @felica = assign(:felica, Felica.create!(
      :idm => "MyString",
      :activation => false
    ))
  end

  it "renders the edit felica form" do
    render

    assert_select "form[action=?][method=?]", felica_path(@felica), "post" do

      assert_select "input#felica_idm[name=?]", "felica[idm]"

      assert_select "input#felica_activation[name=?]", "felica[activation]"
    end
  end
end
