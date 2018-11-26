require "rails_helper"

RSpec.describe "routes for products", :type => :routing do
  let!(:manufacturer) {FactoryBot.create :manufacturer}
  let!(:category) {FactoryBot.create :category}
  let!(:product) {FactoryBot.create :product, category: category, manufacturer: manufacturer}

  it "routes /products to products#index" do
    expect(get: "/products").to route_to(controller: "products", action: "index")
  end

  it "routes /products to products#new"   do
    expect(get: "/products/new").to route_to(controller: "products", action: "new")
  end

  it "routes /products to products#create" do
    expect(post: "/products").to route_to(controller: "products", action: "create")
  end

  it "routes /products to products#show" do
    expect(get: "/products/#{product.id}").to route_to(controller: "products",
      action: "show", id: "#{product.id}")
  end

  it "routes /products to products#edit" do
    expect(get: "/products/#{product.id}/edit").to route_to(controller: "products",
      action: "edit", id: "#{product.id}")
  end

  it "routes /products to products#update" do
    expect(put: "/products/#{product.id}").to route_to(controller: "products",
      action: "update",   id: "#{product.id}")
  end

  it "routes /products to products#destroy" do
    expect(delete: "/products/#{product.id}").to route_to(controller: "products",
      action: "destroy", id: "#{product.id}")
  end

  it "routes /products/price to products#price" do
    expect(get: "/products/price").to route_to(controller: "products", action: "price")
  end
end
