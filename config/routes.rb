Slooly::Application.routes.draw do
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