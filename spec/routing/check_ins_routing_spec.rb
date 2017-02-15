require "rails_helper"

RSpec.describe CheckInsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/check_ins").to route_to("check_ins#index")
    end

    it "routes to #new" do
      expect(:get => "/check_ins/new").to route_to("check_ins#new")
    end

    it "routes to #show" do
      expect(:get => "/check_ins/1").to route_to("check_ins#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/check_ins/1/edit").to route_to("check_ins#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/check_ins").to route_to("check_ins#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/check_ins/1").to route_to("check_ins#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/check_ins/1").to route_to("check_ins#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/check_ins/1").to route_to("check_ins#destroy", :id => "1")
    end

  end
end
