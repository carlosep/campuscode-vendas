Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :orders, only: [:new, :create, :show, :edit, :update]
  resources :customers, only: [:new, :create, :show, :edit, :update]
  resources :users, only: [:show]
end
