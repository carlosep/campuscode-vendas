Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :customers, only: [:new, :create, :show, :edit, :update]
  resources :orders, only: [:new, :create, :show]
end
