require "rails_helper"

RSpec.describe "routes for categories", :type => :routing do
  let!(:category) {FactoryBot.create :category}

  it "routes /categories to categories#index" do
    expect(get: "/categories").to route_to(controller: "categories", action: "index")
  end

  it "routes /categories to categories#new" do
    expect(get: "/categories/new").to route_to(controller: "categories", action: "new")
  end

  it "routes /categories to categories#create" do
    expect(post: "/categories").to route_to(controller: "categories", action: "create")
  end

  it "routes /categories to categories#show" do
    expect(get: "/categories/#{category.id}").to route_to(controller: "categories",
      action: "show", id: "#{category.id}")
  end

  it "routes /categories to categories#edit" do
    expect(get: "/categories/#{category.id}/edit").to route_to(controller: "categories",
      action: "edit", id: "#{category.id}")
  end

  it "routes /categories to categories#update" do
    expect(put: "/categories/#{category.id}").to route_to(controller: "categories",
      action: "update",   id: "#{category.id}")
  end

  it "routes /categories to categories#destroy" do
    expect(delete: "/categories/#{category.id}").to route_to(controller: "categories",
      action: "destroy", id: "#{category.id}")
  end
end
