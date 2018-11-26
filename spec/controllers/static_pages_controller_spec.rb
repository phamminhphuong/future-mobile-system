require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  let!(:manufacturer) {FactoryBot.create :manufacturer}
  let!(:category) {FactoryBot.create :category}
  let!(:product) {FactoryBot.create :product, category: category, manufacturer: manufacturer}
  describe "About" do
    it "Renders the about template" do
      get :about
      expect(response).to render_template("static_pages/about")
    end
  end

  describe "Contact" do
    it "Renders the contact template" do
      get :contact
      expect(response).to render_template("static_pages/contact")
    end
  end

  describe "Introduct" do
    it "Renders the introduct template" do
      get :introduct
      expect(response).to render_template("static_pages/introduct")
    end
  end

  describe "Search" do
    it "Home search" do
      get :home
      expect(assigns(:products)).to eq [product]
    end
  end

  describe "Home" do
    it "Assigns @product" do
      get :home
      expect(assigns(:products)).to eq [product]
    end

    it "Assigns @product not found" do
      get :home
      expect(assigns(:products)).to be_truthy
    end


    it "Renders the introduct template" do
      get :home
      expect(assigns(:products)).to render_template("static_pages/home")
    end
  end
end
