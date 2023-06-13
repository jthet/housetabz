Rails.application.routes.draw do
  devise_for :users

  root "home_page#index"

  resources :users do
    resource :profile, only: [:new, :create, :show, :edit, :update]
    resources :houses, only: [:show]
  end
  
  
  resources :houses, only: [:show, :new]
  get 'house/join', to: 'houses#join', as: 'join_house'
  post 'house/create', to: 'houses#create', as: 'create_house'

  get 'join_house', to: 'houses#join'
  post 'join_house', to: 'houses#join_house'
  
  get 'house_options', to: 'houses#house_options'
  

end


