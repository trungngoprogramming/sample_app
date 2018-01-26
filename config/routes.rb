Rails.application.routes.draw do

  scope "(:locale)", locale:/en|vi/ do
    root "static_pages#home"

    get  "/help",    to: "static_pages#help"

    get  "/signup",  to: "users#new"

    post "/signup",  to: "users#create"

    get "/login", to: "sessions#new"

    post "/login", to: "sessions#create"

    delete "/logout", to: "sessions#destroy"

    get "/users", to: "users#index"

    get "/password_resets", to: "password_resets#new"
  end
    get "/edit", to: "users#edit"

    patch "/edit", to: "users#update"

    resources :users

    resources :account_activations, only: [:edit]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
