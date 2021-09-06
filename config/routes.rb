Rails.application.routes.draw do
  get 'user/show'
  get 'user/new'
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    get 'home/index'
    resources :posts
    root 'static_pages#home', as: "home"
    get 'static_pages/help', as: "help"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users, only: %i(:edit, :update :show)
  end
end
