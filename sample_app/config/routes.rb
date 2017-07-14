Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root "static_pages#show", pages: "home"
  get "static_pages/*pages", to: "static_pages#show"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post "/active_relationship", to: "users#active_relationship"
  delete "/passtive_relationship", to: "users#passtive_relationship"
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: :edit
  resources :password_resets, except: [:index, :show, :destroy]
  resources :posts, only: [:create, :show, :destroy] do
    resources :comments, except: [:index, :new, :show]
  end
  resources :relationships, only: [:create, :destroy]
end
