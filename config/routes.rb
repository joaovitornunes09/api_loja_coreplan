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
  get "/resume/order/products/:id", to: "resume_orders#get_resume_order_with_products"
  get "/resume/orders/user", to: "resume_orders#get_user_resume_order_with_products"
end
