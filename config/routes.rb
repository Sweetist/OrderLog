Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'deliveries#index'

  get 'deliveries', to: 'deliveries#index'  
  delete 'deliveries', to: 'deliveries#destroy'

  get 'orders', to: 'orders#index'
  delete 'orders', to: 'orders#destroy'

  get 'bakeries', to: 'bakeries#index'
  delete 'bakeries', to: 'bakeries#destroy'

  get 'recipients', to: 'recipients#index'
  delete 'recipients', to: 'recipients#destroy'
  
  resources :deliveries
  resources :bakeries
  resources :orders
  resources :recipients
end