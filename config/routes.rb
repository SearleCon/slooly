Slooly::Application.routes.draw do
  resources :plans

  # resources :subscriptions
  
  resources :payment_notifications, controller: 'payment_notification',  only: [:create]
  
  resources :subscriptions do
    get :payment_plans, on: :collection
  end  
  
  resources :announcements

  resources :histories

  get "pages/home"

  get "pages/about"

  get "pages/ie_warning"

  get "pages/faq"

  get "pages/help"

  get "pages/news"

  get "pages/reports"
  
  get "pages/initial_setup"
  
  get "pages/pricing"

  get "pages/tos"

  get "pages/tutorial"

  get "pages/privacy"
  
  get "paypal/checkout", to: "subscriptions#paypal_checkout"
  
  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post  
  
  match 'redeem' => 'vouchers#redeem', :as => 'redeem', via: :put

  resources :suggestions

  resources :settings

  resources :clients do
    new do
     get :import_clients, :as => :import
    end

  end

  resources :companies

  resources :statuses

  resources :invoices

  match 'clients/import', as: :import, :via => :post
  

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
#  devise_for :users
  
  devise_for :users, :controllers => {:sessions => "sessions"}
  resources :users, :only => [:show, :index]
  
  # Any other routes are handled here (as ActionDispatch prevents RoutingError from hitting ApplicationController::rescue_action).
  match "*path", :to => "application#routing_error"
end
