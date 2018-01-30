Rails.application.routes.draw do

  scope "(:locale)", locale:/en|vi/ do
    root "static_pages#home"

    get  "/help",    to: "static_pages#help"

    get  "/signup",  to: "users#new"

    post "/signup",  to: "users#create"

    get "/login", to: "sessions#new"

    post "/login", to: "sessions#create"

    delete "/logout", to: "sessions#destroy"

    get "/password_resets", to: "password_resets#new"
  end

    resources :users

    resources :password_resets, only: [:create, :edit, :update]

    resources :account_activations, only: [:edit]

    resources :microposts, only: [:create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
