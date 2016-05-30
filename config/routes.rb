Rails.application.routes.draw do
  constraints subdomain: 'api' do
    scope module: 'api' do
      namespace :v1 do
        resources :groups
        resources :users
        post 'authenticate', to: 'authentication#authenticate'
        post 'refresh_token', to: 'authentication#refresh_token'
        get 'decode_token', to: 'authentication#decode_token'
      end
    end
  end
end
