# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # order
  post '/place_order', to: 'order#place_order', as: 'place_order'
  get '/user/pre-orders', to: 'order#pre_orders', as: 'user_pre_orders'
  
  namespace :user do
    resources :locations
    resources :categories
    resources :products
    # pro-order add to cart routes
    get '/pre_order/add_cart', to: 'products#add_cart', as: 'pre_order_add_cart'
    post '/pre_order/update_cart', to: 'products#update_cart', as: 'pre_order_update_cart'
    post '/pre_order/remove_cart', to: 'products#remove_cart', as: 'pre_order_remove_cart'
  end
end
