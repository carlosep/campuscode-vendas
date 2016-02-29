Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :customers, except: :destroy do
    collection do
      get 'search'
    end
  end

  resources :orders, except: [:destroy] do
    put :order_status, on: :member
  end

  resources :users, except: [:destroy]
end
