Rails.application.routes.draw do
  root to: "users#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/home", to: "home#index"

  get "/maps", to: "maps#index"

  resources :users, only: [ :new, :create ]
  resources :categories, only: [ :index, :new, :create ]
  resources :brands, only: [ :index, :new, :create ]
  resources :colors, only: [ :index, :new, :create ]
  resources :maps, only: [ :index ]

  resources :clothes do
    member do
      post :usage_log
    end
  end
end
