Rails.application.routes.draw do
  # ルートページ
  root to: "home#index"

  # セッション管理
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # メインページ
  get "/graph", to: "graph#index"
  get "/maps", to: "maps#index"

  # ユーザー管理
  resources :users, only: [ :new, :create ] # 新規登録用

  resource :user, only: [ :edit, :update, :destroy ] do # マイページ用
    get "password/edit", to: "users#edit_password", as: :edit_password
    patch "password", to: "users#password_update", as: :user_password
    get "destroy", to: "users#unsubscribe", as: :unsubscribe
    delete "withdraw", to: "users#destroy"
  end

  # マスターデータ管理
  resources :categories, only: [ :index, :new, :create ]
  resources :brands, only: [ :index, :new, :create ]
  resources :colors, only: [ :index, :new, :create ]

  # 服の管理
  resources :clothings do
    member do
      post :usage_log
      post :remove_usage_log
    end
  end
end
