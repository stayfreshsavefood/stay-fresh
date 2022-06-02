Rails.application.routes.draw do
  devise_for :users
  # root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "fridges#index"
  resources :fridges, only: [:show, :create, :update, :destroy] do
    resources :ingredients, only: [:new, :create, :update, :edit]
    resources :invitations, only: [:new, :create]
    resources :expiry_notifications, only: [:edit, :update]
  end

  resources :invitations, only: [:destroy]
  resources :ingredients, only: [:destroy]
  resources :expiry_notification, only: [:destroy]
end
