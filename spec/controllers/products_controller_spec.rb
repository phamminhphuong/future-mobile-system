require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  let!(:manufacturer) {FactoryBot.create :manufacturer}
  let!(:category) {FactoryBot.create :category}
  let!(:product) {FactoryBot.create :product, category: category, manufacturer: manufacturer}
  let!(:account) {FactoryBot.create :account}
  let!(:comment) {FactoryBot.create :comment, product: product, account: account}
  # let!(:image) {FactoryBot.create :image, product: product}

  describe "Show product" do
    it "Render product show template" do
      get :show, params: {id: product.id}
      expect(response).to render_template("products/show")
    end

    it "Assigns @details" do
      get :show, params: {id: product.id}
      expect(assigns(:details)).to eq [product]
    end

    it "Assigns @details not found" do
      get :show, params: {id: product.id}
      expect(assigns(:details)).to be_truthy
    end

    it "Assigns @comments" do
      get :show, params: {id: product.id}
      expect(assigns(:comments)).to eq [comment]
    end

    it "Assigns @comments not found" do
      get :show, params: {id: product.id}
      expect(assigns(:comments)).to be_truthy
    end
  end

  describe "Price product" do
    it "Render product by price template" do
       get :price
       expect(response).to render_template("products/price")
    end
  end
end
