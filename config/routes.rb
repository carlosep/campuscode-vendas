Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  resources :orders, only: [:new, :create, :show, :edit, :update]
  resources :customers, only: [:new, :create, :show, :edit, :update] do
    collection do
      get 'search'
    end
  end

  resources :users, except: [:destroy]
end
