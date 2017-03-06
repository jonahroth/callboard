require "rails_helper"

RSpec.describe CrewRolesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/crew_roles").to route_to("crew_roles#index")
    end

    it "routes to #new" do
      expect(:get => "/crew_roles/new").to route_to("crew_roles#new")
    end

    it "routes to #show" do
      expect(:get => "/crew_roles/1").to route_to("crew_roles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/crew_roles/1/edit").to route_to("crew_roles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/crew_roles").to route_to("crew_roles#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/crew_roles/1").to route_to("crew_roles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/crew_roles/1").to route_to("crew_roles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/crew_roles/1").to route_to("crew_roles#destroy", :id => "1")
    end

  end
end
