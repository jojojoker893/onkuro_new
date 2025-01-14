Rails.application.routes.draw do
  root to: "users#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, only: [ :new, :create ]
  resources :categories, only: [ :index, :new, :create ]
  resources :brands, only: [ :index, :new, :create ]
  resources :colors, only: [ :index, :new, :create ]
  resources :clothes
end
