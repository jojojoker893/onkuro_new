Rails.application.routes.draw do
  root to: "home#index"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/graph", to: "graph#index"
  get "/maps", to: "maps#index"

  resources :users, only: [ :new, :create ] # 新規登録用

  resource :user, only: [ :edit, :update, :destroy ] do # マイページ用
    get "password/edit", to: "users#edit_password", as: :edit_password
    patch "password", to: "users#password_update", as: :user_password
    get "destroy", to: "users#unsubscribe", as: :unsubscribe
    delete "withdraw", to: "users#destroy"
  end

  resources :categories, only: [ :index, :new, :create ]
  resources :brands, only: [ :index, :new, :create ]
  resources :colors, only: [ :index, :new, :create ]
  resources :maps, only: [ :index ]

  resources :clothings do
    member do
      post :usage_log
      post :remove_usage_log
    end
  end
end
