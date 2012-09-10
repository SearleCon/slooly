Slooly::Application.routes.draw do
  get "pages/home"

  get "pages/about"

  get "pages/contact"

  get "pages/help"

  get "pages/news"

  get "pages/reports"
  
  get "pages/initial_setup"

  resources :suggestions

  resources :settings

  resources :clients

  resources :companies

  resources :statuses

  resources :invoices

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users, :only => [:show, :index]  
end
