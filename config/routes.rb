Slooly::Application.routes.draw do
  resources :announcements

  resources :histories

  get "pages/home"

  get "pages/about"

  get "pages/faq"

  get "pages/help"

  get "pages/news"

  get "pages/reports"
  
  get "pages/initial_setup"
  
  get "pages/pricing"

  get "pages/tos"

  get "pages/tutorial"

  get "pages/privacy"
  
  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post  

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
  
  # Any other routes are handled here (as ActionDispatch prevents RoutingError from hitting ApplicationController::rescue_action).
  match "*path", :to => "application#routing_error"
end
