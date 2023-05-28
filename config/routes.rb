Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: "pages#home"
  get "meetings/analytics", to: "meetings#analytics"

  resources :meetings do
    resources :bookings, only: [:edit, :update]
    resources :messages, only: :create
  end
  resources :bookings, only: [:destroy]
  get "users/:id/card", to: "users#card", as: "user_card"
  get '/redirect', to: 'meetings#redirect', as: 'redirect'
  get '/callback', to: 'meetings#callback', as: 'callback'
end
