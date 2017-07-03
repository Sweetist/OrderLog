Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'unified#index'
  get 'unified', to: 'unified#index'
  post 'unified', to: 'unified#create'

  get 'deliveries', to: 'deliveries#index'  
  delete 'deliveries', to: 'deliveries#destroy'

  get 'orders', to: 'orders#index'
  delete 'orders', to: 'orders#destroy'

  get 'bakeries', to: 'bakeries#index'
  delete 'bakeries', to: 'bakeries#destroy'

  get 'recipients', to: 'recipients#index'
  delete 'recipients', to: 'recipients#destroy'
  
  get 'unified', to: 'unified#index'

  resources :deliveries
  resources :bakeries
  resources :orders
  resources :recipients
end