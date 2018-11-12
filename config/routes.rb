Rails.application.routes.draw do
  devise_for :account
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/search", to: "static_pages#search"
  get "/contact", to: "static_pages#contact"
  get "/introduct", to: "static_pages#introduct"
  get "/card", to: "cards#show"
  get "/pay", to: "pays#show"
  post "/pay", to: "pays#create", as: "checkout"
  get "/products/price", to: "products#price"
  resources :categories
  resources :products do
    resources :comments
  end
  resources :order_details
  resources :cards, only: %i(show destroy)
  namespace :admin do
    get "dasboard/index", to: "dasboard#index"
    resources :accounts
    resources :categories, :manufacturers, :products do
      collection {post :import}
    end
    resources :orders
    resources :images
    resources :comments
    resources :orders
    resources :xml, only: %i(index)
    get "/statistic", to: "orders#statistic"
  end
end
