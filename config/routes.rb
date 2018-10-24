Rails.application.routes.draw do
  get "static_pages/home"
  get "static_pages/about"
  root "static_pages#home"
  namespace :admin do
    get "dasboard/index", to: "dasboard#index"
    resources :accounts
    resources :categorys
    resources :manufacturers
    resources :products
    resources :orders
  end
end
