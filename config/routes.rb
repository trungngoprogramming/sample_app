Rails.application.routes.draw do

  scope "(:locale)", locale:/en|vi/ do
    root "static_pages#home"

    get  "/help",    to: "static_pages#help"

    get  "/signup",  to: "users#new"

    post "/signup",  to: "users#create"
  end
    resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
