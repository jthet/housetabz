Rails.application.routes.draw do
  resources :profiles
  devise_for :users 

  root "home_page#index"

  patch 'profile/:id/edit', to: 'profiles#update', as: 'update_user_profile'
  get 'profile/:id/edit', to: 'profiles#edit', as: 'edit_user_profile'
  get 'profile/:id', to: 'profiles#show', as: 'user_profile'
  
  get 'houses/:id', to: 'houses#show', as: 'user_house'

end
