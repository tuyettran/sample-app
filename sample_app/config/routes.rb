Rails.application.routes.draw do
  root "static_pages#show", page: "home"
  get "static_pages/*page", to: "static_pages#show"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users
end
