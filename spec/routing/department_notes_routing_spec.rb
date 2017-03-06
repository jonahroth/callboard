require "rails_helper"

RSpec.describe DepartmentNotesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/department_notes").to route_to("department_notes#index")
    end

    it "routes to #new" do
      expect(:get => "/department_notes/new").to route_to("department_notes#new")
    end

    it "routes to #show" do
      expect(:get => "/department_notes/1").to route_to("department_notes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/department_notes/1/edit").to route_to("department_notes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/department_notes").to route_to("department_notes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/department_notes/1").to route_to("department_notes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/department_notes/1").to route_to("department_notes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/department_notes/1").to route_to("department_notes#destroy", :id => "1")
    end

  end
end
