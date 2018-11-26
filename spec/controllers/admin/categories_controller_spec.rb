require "rails_helper"

RSpec.describe Admin::CategoriesController, type: :controller do
  let!(:category) {FactoryBot.create :category}

  describe "Admin/category controller test action index" do
    it "GET index template" do
      get :index
      expect(response).to render_template :index
    end

    it "Assigns @categories" do
      get :index
      expect(assigns(:categories)).to eq [category]
    end
  end

  # describe "Admin/category controller test action show" do
  #   it "GET index template" do
  #     get :show, params: {id: category.id}
  #     # expect(response).to render_template("admin/categories/show")
  #   end

  #   it "Assigns @category" do
  #     get :show, params: {id: category.id}
  #     # byebug
  #     # expect(assigns(:category)).to eq [category]
  #   end
  # end

end
