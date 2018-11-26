require "rails_helper"

RSpec.describe "static_pages/home", type: :view do
  let!(:manufacturer) {FactoryBot.create :manufacturer}
  let!(:category) {FactoryBot.create :category}
  let!(:product) {FactoryBot.create :product, category: category, manufacturer: manufacturer}

  it "displays the widget" do
    render :template => "static_pages/home.html.erb"

    expect(rendered).to match /slicer/
  end
end
