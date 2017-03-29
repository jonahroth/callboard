require "rails_helper"

RSpec.describe PersonWorksController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/person_works").to route_to("person_works#index")
    end

    it "routes to #new" do
      expect(:get => "/person_works/new").to route_to("person_works#new")
    end

    it "routes to #show" do
      expect(:get => "/person_works/1").to route_to("person_works#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/person_works/1/edit").to route_to("person_works#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/person_works").to route_to("person_works#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/person_works/1").to route_to("person_works#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/person_works/1").to route_to("person_works#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/person_works/1").to route_to("person_works#destroy", :id => "1")
    end

  end
end
