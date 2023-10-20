Rails.application.routes.draw do
  get 'webhooks/stripe'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  root "home_page#index"

  resources :users do
    resource :profile, only: [:new, :create, :show, :edit, :update]
    resources :houses, only: [:show]
  end

  resources :profiles, only: [:new, :create]
  
  get '/my_profile', to: 'profiles#show', as: :my_profile
  
  resources :houses, only: [:show, :new] do
    post 'join', on: :collection, to: 'houses#join_process'
  end

  resources :charges do
    post 'send_reminder', on: :member
  end
  

  get 'house/join', to: 'houses#join', as: 'join_house'
  post 'house/join', to: 'houses#join_process'

  post 'house/create', to: 'houses#create', as: 'create_house'

  get 'join_house', to: 'houses#join'

  get 'house_options', to: 'houses#house_options'

  get 'add_services', to: 'houses#add_services', as: 'add_services_house'

  get 'city_of_austin_utilities', to: 'services#city_of_austin_utilities'
  post 'create_city_of_austin_utilities_service', to: 'services#create_city_of_austin_utilities_service'

  get 'texas_gas', to: 'services#texas_gas'
  post 'create_texas_gas_service', to: 'services#create_texas_gas_service'
  
  get 'wifi', to: 'services#wifi'
  post 'create_wifi_service', to: 'services#create_wifi_service'

  get '/members/:id', to: 'members#show', as: 'member_profile'

  get '/payment', to: 'payments#show', as: 'make_payment'

  get '/checkout', to: 'checkout#new'
  post '/create_checkout_session', to: 'checkout#create_checkout_session'

  post '/webhooks/stripe', to: 'webhooks#stripe'

  get 'checkout_cancel', to: 'checkout#checkout_cancel'
  get 'checkout_success', to: 'checkout#checkout_success', as: 'checkout_success'

  get 'about', to: 'home_page#about', as: 'about'

  resources :contacts, only: [:new, :create]

  resources :users do
    member do
      post 'send_message'
    end
  end
  
  put '/messages/:id/mark_as_read', to: 'messages#mark_as_read', as: 'mark_as_read_message'
  get '/messages/show', to: 'messages#show', as: 'messages_show'

  resources :users do
    member do
      put 'mark_as_read', to: 'users#mark_as_read'
    end
  end

  resources :houses do
    resources :bills, only: [:show] # This will create a route for viewing a specific bill
  end
  
end
