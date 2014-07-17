require 'rails_helper'

RSpec.describe "felicas/show", :type => :view do
  before(:each) do
    @felica = assign(:felica, Felica.create!(
      :idm => "Idm",
      :activation => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Idm/)
    expect(rendered).to match(/false/)
  end
end
