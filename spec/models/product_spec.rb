require "rails_helper"

RSpec.describe Product, type: :model do
  context "Associations test" do
    it{is_expected.to belong_to :category}
    it{is_expected.to belong_to :manufacturer}
    it{is_expected.to have_many :images}
    it{is_expected.to have_many :comments}
    it{is_expected.to have_many :order_details}
  end

  context "Columns test" do
    it{is_expected.to have_db_column(:name).of_type :string}
    it{is_expected.to have_db_column(:quantity).of_type :integer}
    it{is_expected.to have_db_column(:price).of_type :decimal}
    it{is_expected.to have_db_column(:description).of_type :text}
    it{is_expected.to have_db_column(:hot).of_type :integer}
    it{is_expected.to have_db_column(:category_id).of_type :integer}
    it{is_expected.to have_db_column(:manufacturer_id).of_type :integer}
  end

  context "Validations test" do
    it{is_expected.to validate_presence_of :name}
    it{is_expected.to validate_length_of(:name).is_at_most 255}
    it{is_expected.to validate_presence_of :quantity}
    it{is_expected.to validate_numericality_of :quantity}
    it{is_expected.to validate_presence_of :price}
    it{is_expected.to validate_presence_of :description}
    it{is_expected.to validate_length_of(:description).is_at_most 2000}
    it{is_expected.to validate_presence_of :hot}
    it{is_expected.to validate_numericality_of :hot}
    it{is_expected.to delegate_method(:name).to(:manufacturer).with_prefix true}
    it{is_expected.to delegate_method(:name).to(:category).with_prefix true}
  end

  context "Scope test" do
    let!(:manufacturer) {FactoryBot.create :manufacturer}
    let!(:category) {FactoryBot.create :category}
    let!(:product) {FactoryBot.create :product, category: category, manufacturer: manufacturer}

    it "scope select where by category_id" do
      expect(Product.show_product category.id).to eq [product]
    end

    it "Scope select product sort by create_at" do
      expect(Product.show_product_desc).to eq [product]
    end

    it "Scope select product sort by hot" do
      expect(Product.show_product_hot_desc).to eq [product]
    end

    it "Scope select product by column" do
      expect(Product.select_products).to eq [product]
    end

    it "Scope show product price" do
      expect(Product.show_product_price 1, 1000).to eq [product]
    end

    it "Scope show product price not found" do
      expect(Product.show_product_price 1, 1000).to be_truthy
    end

    it "Scope show product by id" do
      expect(Product.show_detail product.id).to eq [product]
    end

    it "Scope show product by id not found" do
      expect(Product.show_detail product.id).to be_truthy
    end

    it "Scope find product by id" do
      expect(Product.find_product product.id).to eq [product]
    end

    it "Scope find product by id not found" do
      expect(Product.find_product product.id).to be_truthy
    end

    it "Scope select category" do
      expect(Category.select_category).to eq [category]
    end

    it "Scope select manufacturer" do
      expect(Manufacturer.select_manufacturer).to eq [manufacturer]
    end
  end
end
