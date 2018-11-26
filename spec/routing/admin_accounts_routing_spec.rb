require "rails_helper"

RSpec.describe "routes for accounts", :type => :routing do
  let!(:account) {FactoryBot.create :account}

  it "routes admin/accounts#index to accounts#index" do
    expect(get: "/admin/accounts").to route_to(controller: "admin/accounts", action: "index")
  end

  it "routes admin/accounts#index to admin/accounts#index" do
    expect(get: "/admin/accounts").to route_to("admin/accounts#index")
  end

  it "routes /admin/accounts/new to admin/accounts#new" do
    expect(get: "/admin/accounts/new").to route_to(controller: "admin/accounts", action: "new")
  end

  it "routes admin/accounts#create to/admin/accounts#create" do
    expect(post: "/admin/accounts").to route_to(controller: "admin/accounts", action: "create")
  end

  it "routes admin/accounts/:id to/admin/accounts#show" do
    expect(get: "/admin/accounts/#{account.id}").to route_to(controller: "admin/accounts",
      action: "show", id: "#{account.id}")
  end

  it "routes  /admin/accounts/:id/edit to admin/accounts#edit" do
    expect(get: "admin/accounts/#{account.id}/edit").to route_to(controller: "admin/accounts",
      action: "edit", id: "#{account.id}")
  end

  it "routes /admin/accounts/:id to admin/accounts#update" do
    expect(put: "/admin/accounts/#{account.id}").to route_to(controller: "admin/accounts",
      action: "update",  id: "#{account.id}")
  end

  it "routes /admin/accounts/:ids to admin/accounts#destroy" do
    expect(delete: "/admin/accounts/#{account.id}").to route_to(controller: "admin/accounts",
      action: "destroy", id: "#{account.id}")
  end
end
