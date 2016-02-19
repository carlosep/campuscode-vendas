Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :orders, except: [:index, :destroy] do
    put :order_status, on: :member
  end
  resources :customers, only: [:new, :create, :show, :edit, :update]
  resources :users, except: [:destroy]
end
