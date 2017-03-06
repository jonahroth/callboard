require "rails_helper"

RSpec.describe CrewCallsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/crew_calls").to route_to("crew_calls#index")
    end

    it "routes to #new" do
      expect(:get => "/crew_calls/new").to route_to("crew_calls#new")
    end

    it "routes to #show" do
      expect(:get => "/crew_calls/1").to route_to("crew_calls#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/crew_calls/1/edit").to route_to("crew_calls#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/crew_calls").to route_to("crew_calls#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/crew_calls/1").to route_to("crew_calls#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/crew_calls/1").to route_to("crew_calls#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/crew_calls/1").to route_to("crew_calls#destroy", :id => "1")
    end

  end
end
