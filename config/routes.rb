Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  
  resources :customers, only: [:new, :create, :show, :edit, :update] do
    collection do
      get 'search'
    end
  end

  resources :orders, except: [:index, :destroy] do
    put :order_status, on: :member
  end

  resources :users, except: [:destroy]
end
