require "rails_helper"

RSpec.describe "routes for comments", :type => :routing do
  let!(:manufacturer) {FactoryBot.create :manufacturer}
  let!(:category) {FactoryBot.create :category}
  let!(:account) {FactoryBot.create :account}
  let!(:product) {FactoryBot.create :product}
  let!(:comment) {FactoryBot.create :comment, account: account, product: product}

  it "routes /products/:product_id/comments to comments#create" do
    expect(post: "/products/#{product.id}/comments").to route_to(controller: "comments",
      action: "create", product_id: "#{product.id}")
  end
đó
  it "routes /products/:product_id/comments/:id/edit to comment#edit" do
    expect(get: "/products/#{product.id}/comments/#{comment.id}/edit").to route_to(controller: "comments",
      action: "edit", product_id: "#{product.id}", id: "#{comment.id}")
  end

  it "routes /products/:product_id/comments/:id to comments#update" do
    expect(put: "/products/#{product.id}/comments/#{comment.id}").to route_to(controller: "comments",
      action: "update", product_id: "#{product.id}", id: "#{comment.id}")
  end

  it "routes / /products/:product_id/comments/:id to comments#destroy" do
    expect(delete: "/products/#{product.id}/comments/#{comment.id}").to route_to(controller: "comments",
      action: "destroy", product_id: "#{product.id}", id: "#{comment.id}")
  end
end
