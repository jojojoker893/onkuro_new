Rails.application.routes.draw do
  root to: "sessions#new"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/home", to: "home#index"
  get "/graph", to: "graph#index"
  get "/maps", to: "maps#index"

  resources :users, only: [ :new, :create ]

  resources :user, only: [ :edit, :update, :destory ] do
    get "password/edit", to: "users#edit_password", as: :edit_password
    patch "password", to: "users#update_password"
    get "unsubscribe", to: "users#unsubscribe", as: :unsubscribe
    delete "withdraw", to: "users#withdraw"
  end

  resources :categories, only: [ :index, :new, :create ]
  resources :brands, only: [ :index, :new, :create ]
  resources :colors, only: [ :index, :new, :create ]
  resources :maps, only: [ :index ]

  resources :clothings do
    member do
      post :usage_log
      delete :remove_usage_log
    end
  end

end
