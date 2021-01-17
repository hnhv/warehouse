Rails.application.routes.draw do
  get '/products', to: 'products#index'
  get '/products/:id', to: 'products#show'
  post '/products/:id/remove', to: 'products#remove'
end
