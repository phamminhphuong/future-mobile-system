require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  let!(:category) {FactoryBot.create :category}
  let!(:product) {FactoryBot.create :product, category: category}

  describe "Category  GET show/:id" do
    it "Render category show template" do
      get :show, params:{id: category.id}
      expect(response).to render_template("categories/show")
    end

    it "Assigns @product" do
      get :show, params:{id: category.id}
      expect(assigns(:products)).to eq [product]
    end

    it "Assigns @product not found" do
      get :show, params:{id: category.id}
      expect(assigns(:products)).to be_truthy
    end
  end
end
