require "rails_helper"

RSpec.describe FelicasController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/felicas").to route_to("felicas#index")
    end

    it "routes to #new" do
      expect(:get => "/felicas/new").to route_to("felicas#new")
    end

    it "routes to #show" do
      expect(:get => "/felicas/1").to route_to("felicas#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/felicas/1/edit").to route_to("felicas#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/felicas").to route_to("felicas#create")
    end

    it "routes to #update" do
      expect(:put => "/felicas/1").to route_to("felicas#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/felicas/1").to route_to("felicas#destroy", :id => "1")
    end

  end
end
