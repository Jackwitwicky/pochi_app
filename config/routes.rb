Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :users
      resources :notifications, only: [:index, :show]

      post :auth, to: 'authentication#create'
      post :top_up, to: 'wallet_transactions#create'
      post :transfer, to: 'fund_transfers#create'
    end
  end
end
