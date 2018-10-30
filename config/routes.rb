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
  get "/card", to: "cards#show"
  resources :accounts
  resources :categories
  resources :products
  namespace :admin do
    get "dasboard/index", to: "dasboard#index"
    resources :accounts
    resources :categories
    resources :manufacturers
    resources :products
    resources :orders
    resources :images
    resources :comments
  end
end
