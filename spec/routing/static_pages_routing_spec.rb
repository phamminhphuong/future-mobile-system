require "rails_helper"

RSpec.describe "routes for static_pages", :type => :routing do
  it "routes /home to static_pages#home" do
    expect(get: "/").to route_to(controller: "static_pages", action: "home")
  end

  it "routes /home to static_pages#home" do
    expect(get: "/").to route_to("static_pages#home")
  end

  it "routes /help to static_pages#help" do
    expect(get: "/help").to route_to("static_pages#help")
  end


  it "routes /about to static_pages#about" do
    expect(get: "/about").to route_to("static_pages#about")
  end

  it "routes /contact to static_pages#contact" do
    expect(get: "/contact").to route_to("static_pages#contact")
  end

  it "routes /search to static_pages#search" do
    expect(get: "/search").to route_to("static_pages#search")
  end
end
