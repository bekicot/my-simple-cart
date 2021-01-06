Rails.application.routes.draw do
  namespace :api do
    scope :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/registrations'
      }
      post '/auth/:provider/connect', to: 'v1/omniauths#create'
      get '/products', to: 'v1/products#index'
      post '/carts/add/:product_variant_id', to: 'v1/carts#add'
      get '/carts', to: 'v1/carts#index'
      put '/carts/item/updates/:id', to: 'v1/carts#update'
      delete '/carts/item/delete/:id', to: 'v1/carts#destroy'
      post '/orders/checkout', to: 'v1/orders#checkout'
      get '/orders', to: 'v1/orders#index'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
