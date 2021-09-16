Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root 'static_pages#home', as: "home"
    get 'static_pages/help', as: "help"

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    get "/edit", to: "users#edit"
    post "/edit", to: "users#update"

    get "/users", to: "users#index"
    resources :users, only: %i(new create show destroy edit update)

    #get "/account_activations", to: "account_activations#edit"
    resources :account_activations, only: [:edit]
    resources :password_resets, only: [:new, :create, :edit, :update]
  end
end
