Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ja/ do
    root 'static_pages#home', as: "home"
    get 'static_pages/help', as: "help"

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: %i(new create show)

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end
end
