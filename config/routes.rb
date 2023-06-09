Rails.application.routes.draw do
  
  root "categories#home"

  get "current_month" => "categories#current_month"
  get "single_month" => "categories#single_month"
  get "past_months" => "categories#past_months"

  resources :categories do
    resources :expenses
  end

  resource :session, only: [:new, :create, :destroy]

  resources :users

  get "signup" => "users#new"
  get "signin" => "users#index"

end
