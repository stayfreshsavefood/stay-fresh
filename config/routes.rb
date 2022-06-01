Rails.application.routes.draw do
  devise_for :users
  # root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "fridges#show"
  resources :fridges do
    resources :ingredients, only: [:new,:create, :destroy]
  end

  resources :ingredients
end
