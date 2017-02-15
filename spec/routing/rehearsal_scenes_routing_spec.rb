require "rails_helper"

RSpec.describe RehearsalScenesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/rehearsal_scenes").to route_to("rehearsal_scenes#index")
    end

    it "routes to #new" do
      expect(:get => "/rehearsal_scenes/new").to route_to("rehearsal_scenes#new")
    end

    it "routes to #show" do
      expect(:get => "/rehearsal_scenes/1").to route_to("rehearsal_scenes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/rehearsal_scenes/1/edit").to route_to("rehearsal_scenes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/rehearsal_scenes").to route_to("rehearsal_scenes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/rehearsal_scenes/1").to route_to("rehearsal_scenes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/rehearsal_scenes/1").to route_to("rehearsal_scenes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/rehearsal_scenes/1").to route_to("rehearsal_scenes#destroy", :id => "1")
    end

  end
end
