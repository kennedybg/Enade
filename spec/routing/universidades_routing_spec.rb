require "rails_helper"

RSpec.describe UniversidadesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/universidades").to route_to("universidades#index")
    end

    it "routes to #new" do
      expect(:get => "/universidades/new").to route_to("universidades#new")
    end

    it "routes to #show" do
      expect(:get => "/universidades/1").to route_to("universidades#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/universidades/1/edit").to route_to("universidades#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/universidades").to route_to("universidades#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/universidades/1").to route_to("universidades#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/universidades/1").to route_to("universidades#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/universidades/1").to route_to("universidades#destroy", :id => "1")
    end

  end
end
