Rails.application.routes.draw do
  get 'line_items/index'

  get 'line_items/new'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #root 'unified#index'
  #get 'unified', to: 'unified#index'
  #post 'unified', to: 'unified#create'
  #get 'unified/edit', to: 'unified#edit'
  root 'deliveries#index'
  
  get 'deliveries', to: 'deliveries#index'  
  delete 'deliveries', to: 'deliveries#destroy'
  get 'deliveries/edit', to: 'deliveries#edit'

  post 'deliveries/transition/:id', to: 'deliveries#transition'

  get 'orders', to: 'orders#index'
  delete 'orders', to: 'orders#destroy'
  get 'orders/edit', to: 'orders#edit'

  get 'bakeries', to: 'bakeries#index'
  delete 'bakeries', to: 'bakeries#destroy'
  get 'bakeries/edit', to: 'bakeries#edit'

  get 'recipients', to: 'recipients#index'
  delete 'recipients', to: 'recipients#destroy'
  get 'recipients/edit', to: 'recipients#edit'
  

  get 'line_items', to: 'line_items#index'
  delete 'line_items', to: 'line_items#destroy'
  get 'line_items/edit', to: 'line_items#edit'

  #get 'unified', to: 'unified#index'

  resources :deliveries
  resources :bakeries
  resources :orders
  resources :recipients
  resources :line_items

  namespace :api, defaults: { format: 'json' } do 

    devise_for :users,  controllers: { sessions: 'api/sessions' }

    #post 'users/sign_in', to: 'sessions#create'
    #mount_devise_token_auth_for 'User', at: 'auth'

    resources :orders
    resources :bakeries 
    resources :recipients 
    resources :deliveries
    resources :line_items
  end
end