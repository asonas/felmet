require 'rails_helper'

RSpec.describe "Felicas", :type => :request do
  describe "GET /felicas" do
    it "works! (now write some real specs)" do
      get felicas_path
      expect(response.status).to be(200)
    end
  end
end
