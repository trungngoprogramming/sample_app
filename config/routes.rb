Rails.application.routes.draw do

  scope "(:locale)", locale:/en|vi/ do
    root "static_pages#home"

    get "static_pages/home"
  end

  scope "(:locale)", locale:/en|vi/ do
    get "static_pages/help"
  end

  scope "(:locale)", locale:/en|vi/ do
    get  "static_pages/about"
  end

get "static_pages/contact"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
