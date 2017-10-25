Rails.application.routes.draw do
  resources :orders
  resources :products
  resources :categories
  resources :users
  get 'userorders/:id' => 'users#get_orders', as: :user_orders
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
