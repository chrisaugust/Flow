Rails.application.routes.draw do
  
  root "categories#home"

  get "current_month" => "categories#current_month"

  resources :categories do
    resources :expenses
  end

  resource :session, only: [:new, :create, :destroy]

  resources :users

  get "signup" => "users#new"
  get "signin" => "users#index"

end
