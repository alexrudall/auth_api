Rails.application.routes.draw do
  resources :users
  post 'authenticate', to: 'authentication#authenticate'
end
