require "rails_helper"

RSpec.describe EventsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/events").to route_to("events#index")
    end

    it "routes to #edit" do
      expect(:get => "/events/1/edit").to route_to("events#edit", :id => "1")
    end

    it "routes to #update" do
      expect(:put => "/events/1").to route_to("events#update", :id => "1")
    end

  end
end
