require "rails_helper"

RSpec.describe CharacterScenesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/character_scenes").to route_to("character_scenes#index")
    end

    it "routes to #new" do
      expect(:get => "/character_scenes/new").to route_to("character_scenes#new")
    end

    it "routes to #show" do
      expect(:get => "/character_scenes/1").to route_to("character_scenes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/character_scenes/1/edit").to route_to("character_scenes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/character_scenes").to route_to("character_scenes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/character_scenes/1").to route_to("character_scenes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/character_scenes/1").to route_to("character_scenes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/character_scenes/1").to route_to("character_scenes#destroy", :id => "1")
    end

  end
end
