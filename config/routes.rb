Rails.application.routes.draw do
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "accounts#new"
  post "/signup", to: "accounts#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/search", to: "static_pages#search"
  get "/contact", to: "static_pages#contact"
  get "/introduct", to: "static_pages#introduct"
  get "/card", to: "cards#show"
  get "/pay", to: "pays#show"
  post "/pay", to: "pays#create", as: "checkout"
  resources :accounts
  resources :categories
  resources :products do
    resources :comments
  end
  resources :order_details
  resources :cards, only: %i(show destroy)
  namespace :admin do
    get "dasboard/index", to: "dasboard#index"
    resources :accounts
    resources :categories
    resources :manufacturers
    resources :products
    resources :orders
    resources :images
    resources :comments
    resources :orders
    resources :xml, only: %i(index)
    get "/statistic", to: "orders#statistic"
  end
end
