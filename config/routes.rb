Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'deliveries', to: 'deliveries#index'  
  delete 'deliveries', to: 'deliveries#destroy'
  get 'orders', to: 'orders#index'
  delete 'deliveries', to: 'deliveries#destroy'
  get 'recipients', to: 'recipients#index'
  delete 'deliveries', to: 'deliveries#destroy'
  get 'bakeries', to: 'bakeries#index'
  delete 'deliveries', to: 'deliveries#destroy'

  resources :deliveries

end
