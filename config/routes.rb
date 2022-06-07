Rails.application.routes.draw do
  devise_for :users
  # root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "fridges#index"
  resources :fridges, only: [:show, :create, :update, :destroy] do
    resources :ingredients, only: [:new,:create,:update,:edit]
    resources :invite_notifications, only: [:new,:create,:show]
  end

  resources :invite_notifications, only: [:index,:update,:destroy]
  resources :expiry_notifications, only: [:index,:update,:destroy]
  resources :ingredients, only: [:destroy]
end
