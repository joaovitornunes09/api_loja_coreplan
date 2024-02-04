Rails.application.routes.draw do
  resources :resume_orders
  resources :offers
  resources :order_items
  resources :orders
  resources :products
  resources :users
  resources :user_types
  
  post "/login", to: "users#login"
  get "/partial/order", to: "offers#get_partial_order_value"
end
