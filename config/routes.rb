Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :orders, only: [:new, :create, :show]
end
