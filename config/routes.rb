Rails.application.routes.draw do
  resources :profiles
  devise_for :users

  root "home_page#index"

  patch 'profile/:id/edit', to: 'profiles#update', as: 'update_user_profile'
  get 'profile/:id/edit', to: 'profiles#edit', as: 'edit_user_profile'
  get 'profile/:id', to: 'profiles#show', as: 'user_profile'

  resources :users do
    resources :houses, only: [:show]
  end
  
  resources :houses, only: [:show, :new]
  get 'house/join', to: 'houses#join', as: 'join_house'
  post 'house/create', to: 'houses#create', as: 'create_house'
end
