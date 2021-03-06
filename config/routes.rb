Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'


  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :companies, only: [ :index, :show, :update, :create, :destroy ]
      resources :tickets, only: [ :index, :show, :update, :create, :destroy ]
      resources :orders, only: [ :index, :show, :update, :create, :destroy ]
    end
  end

  resources :tickets, only: [:show, :create, :dashboard] do
    resources :orders
  end

  get "dashboard", to: "pages#dashboard"
  get "admin", to: "pages#admin"

end
