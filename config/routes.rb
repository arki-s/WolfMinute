Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"
  get "meetings/analytics", to: "meetings#analytics"
  resources :meetings do
    resources :bookings, only: [:edit, :update]
    resources :messages, only: :create
    resources :videos, only: :create
    get '/party', to: 'video#index'
    patch '/party', to: 'video#index'
    get '/screenshare', to: 'video#screenshare'
    post '/name', to: 'video#name'
  end
  resources :videos, only: :update
  resources :bookings, only: [:destroy]
  get "users/:id/card", to: "users#card", as: "user_card"
  get "meetings/:id/duration", to: "meetings#duration", as: "meeting_reason"
end
