Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'unified#index'
  get 'unified', to: 'unified#index'
  post 'unified', to: 'unified#create'
  get 'unified/edit', to: 'unified#edit'

  get 'deliveries', to: 'deliveries#index'  
  delete 'deliveries', to: 'deliveries#destroy'
  get 'deliveries/edit', to: 'deliveries#edit'

  get 'orders', to: 'orders#index'
  delete 'orders', to: 'orders#destroy'
  get 'orders/edit', to: 'orders#edit'

  get 'bakeries', to: 'bakeries#index'
  delete 'bakeries', to: 'bakeries#destroy'
  get 'bakeries/edit', to: 'bakeries#edit'

  get 'recipients', to: 'recipients#index'
  delete 'recipients', to: 'recipients#destroy'
  get 'recipients/edit', to: 'recipients#edit'
  
  get 'unified', to: 'unified#index'

  resources :deliveries
  resources :bakeries
  resources :orders
  resources :recipients
end