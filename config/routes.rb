Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root "home_page#index"

  resources :users do
    resource :profile, only: [:new, :create, :show, :edit, :update]
    resources :houses, only: [:show]
  end
  
  
 resources :houses, only: [:show, :new] do
  post 'join', on: :collection, to: 'houses#join_process'
end

get 'house/join', to: 'houses#join', as: 'join_house'
post 'house/join', to: 'houses#join_process'

post 'house/create', to: 'houses#create', as: 'create_house'

get 'join_house', to: 'houses#join'

get 'house_options', to: 'houses#house_options'

get '/members/:id', to: 'members#show', as: 'member_profile'

get '/payment', to: 'payments#show', as: 'make_payment'

get '/checkout', to: 'checkout#new'
post '/create_checkout_session', to: 'checkout#create_checkout_session'

get 'checkout_cancel', to: 'checkout#checkout_cancel'
get 'checkout_success', to: 'checkout#checkout_success'




end


