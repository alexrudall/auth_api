Rails.application.routes.draw do
  resources :users
  post 'authenticate', to: 'authentication#authenticate'
  post 'refresh_token', to: 'authentication#refresh_token'
  get 'decode_token', to: 'authentication#decode_token'
end
