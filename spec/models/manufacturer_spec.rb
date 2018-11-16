require "rails_helper"

RSpec.describe Manufacturer, type: :model do
  context "Associations test" do
    it{is_expected.to have_many :products}
  end

  context "Columns test" do
    it{is_expected.to have_db_column(:name).of_type :string}
  end

  context "Validations test" do
    it{is_expected.to validate_presence_of :name}
    it{is_expected.to validate_length_of(:name).is_at_most 255}
  end

  context "Scope test" do
    let!(:manufacturer) {FactoryBot.create :manufacturer}

    it "scope select manufacturer success" do
      expect(Manufacturer.select_manufacturer).to eq [manufacturer]
    end
  end
end
