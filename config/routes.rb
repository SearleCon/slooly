# == Route Map (Updated 2014-04-16 08:50)
#
#                       plans GET    /plans(.:format)                       plans#index
#                             POST   /plans(.:format)                       plans#create
#                    new_plan GET    /plans/new(.:format)                   plans#new
#                   edit_plan GET    /plans/:id/edit(.:format)              plans#edit
#                        plan GET    /plans/:id(.:format)                   plans#show
#                             PUT    /plans/:id(.:format)                   plans#update
#                             DELETE /plans/:id(.:format)                   plans#destroy
#       payment_notifications POST   /payment_notifications(.:format)       payment_notification#create
# payment_plans_subscriptions GET    /subscriptions/payment_plans(.:format) subscriptions#payment_plans
#               subscriptions GET    /subscriptions(.:format)               subscriptions#index
#                             POST   /subscriptions(.:format)               subscriptions#create
#            new_subscription GET    /subscriptions/new(.:format)           subscriptions#new
#           edit_subscription GET    /subscriptions/:id/edit(.:format)      subscriptions#edit
#                subscription GET    /subscriptions/:id(.:format)           subscriptions#show
#                             PUT    /subscriptions/:id(.:format)           subscriptions#update
#                             DELETE /subscriptions/:id(.:format)           subscriptions#destroy
#               announcements GET    /announcements(.:format)               announcements#index
#                             POST   /announcements(.:format)               announcements#create
#            new_announcement GET    /announcements/new(.:format)           announcements#new
#           edit_announcement GET    /announcements/:id/edit(.:format)      announcements#edit
#                announcement GET    /announcements/:id(.:format)           announcements#show
#                             PUT    /announcements/:id(.:format)           announcements#update
#                             DELETE /announcements/:id(.:format)           announcements#destroy
#                   histories GET    /histories(.:format)                   histories#index
#                             POST   /histories(.:format)                   histories#create
#                 new_history GET    /histories/new(.:format)               histories#new
#                edit_history GET    /histories/:id/edit(.:format)          histories#edit
#                     history GET    /histories/:id(.:format)               histories#show
#                             PUT    /histories/:id(.:format)               histories#update
#                             DELETE /histories/:id(.:format)               histories#destroy
#                  pages_home GET    /pages/home(.:format)                  pages#home
#                 pages_about GET    /pages/about(.:format)                 pages#about
#            pages_ie_warning GET    /pages/ie_warning(.:format)            pages#ie_warning
#                   pages_faq GET    /pages/faq(.:format)                   pages#faq
#                  pages_help GET    /pages/help(.:format)                  pages#help
#                  pages_news GET    /pages/news(.:format)                  pages#news
#               pages_reports GET    /pages/reports(.:format)               pages#reports
#         pages_initial_setup GET    /pages/initial_setup(.:format)         pages#initial_setup
#               pages_pricing GET    /pages/pricing(.:format)               pages#pricing
#                   pages_tos GET    /pages/tos(.:format)                   pages#tos
#              pages_tutorial GET    /pages/tutorial(.:format)              pages#tutorial
#               pages_privacy GET    /pages/privacy(.:format)               pages#privacy
#             paypal_checkout GET    /paypal/checkout(.:format)             subscriptions#paypal_checkout
#                     contact GET    /contact(.:format)                     contact#new
#                     contact POST   /contact(.:format)                     contact#create
#                      redeem PUT    /redeem(.:format)                      vouchers#redeem
#                 suggestions GET    /suggestions(.:format)                 suggestions#index
#                             POST   /suggestions(.:format)                 suggestions#create
#              new_suggestion GET    /suggestions/new(.:format)             suggestions#new
#             edit_suggestion GET    /suggestions/:id/edit(.:format)        suggestions#edit
#                  suggestion GET    /suggestions/:id(.:format)             suggestions#show
#                             PUT    /suggestions/:id(.:format)             suggestions#update
#                             DELETE /suggestions/:id(.:format)             suggestions#destroy
#                    settings GET    /settings(.:format)                    settings#index
#                             POST   /settings(.:format)                    settings#create
#                 new_setting GET    /settings/new(.:format)                settings#new
#                edit_setting GET    /settings/:id/edit(.:format)           settings#edit
#                     setting GET    /settings/:id(.:format)                settings#show
#                             PUT    /settings/:id(.:format)                settings#update
#                             DELETE /settings/:id(.:format)                settings#destroy
#           import_new_client GET    /clients/new/import_clients(.:format)  clients#import_clients
#                     clients GET    /clients(.:format)                     clients#index
#                             POST   /clients(.:format)                     clients#create
#                  new_client GET    /clients/new(.:format)                 clients#new
#                 edit_client GET    /clients/:id/edit(.:format)            clients#edit
#                      client GET    /clients/:id(.:format)                 clients#show
#                             PUT    /clients/:id(.:format)                 clients#update
#                             DELETE /clients/:id(.:format)                 clients#destroy
#                   companies GET    /companies(.:format)                   companies#index
#                             POST   /companies(.:format)                   companies#create
#                 new_company GET    /companies/new(.:format)               companies#new
#                edit_company GET    /companies/:id/edit(.:format)          companies#edit
#                     company GET    /companies/:id(.:format)               companies#show
#                             PUT    /companies/:id(.:format)               companies#update
#                             DELETE /companies/:id(.:format)               companies#destroy
#                    statuses GET    /statuses(.:format)                    statuses#index
#                             POST   /statuses(.:format)                    statuses#create
#                  new_status GET    /statuses/new(.:format)                statuses#new
#                 edit_status GET    /statuses/:id/edit(.:format)           statuses#edit
#                      status GET    /statuses/:id(.:format)                statuses#show
#                             PUT    /statuses/:id(.:format)                statuses#update
#                             DELETE /statuses/:id(.:format)                statuses#destroy
#                    invoices GET    /invoices(.:format)                    invoices#index
#                             POST   /invoices(.:format)                    invoices#create
#                 new_invoice GET    /invoices/new(.:format)                invoices#new
#                edit_invoice GET    /invoices/:id/edit(.:format)           invoices#edit
#                     invoice GET    /invoices/:id(.:format)                invoices#show
#                             PUT    /invoices/:id(.:format)                invoices#update
#                             DELETE /invoices/:id(.:format)                invoices#destroy
#                      import POST   /clients/import(.:format)              clients#import
#                        root        /                                      home#index
#                        root        /                                      home#index
#            new_user_session GET    /users/sign_in(.:format)               sessions#new
#                user_session POST   /users/sign_in(.:format)               sessions#create
#        destroy_user_session DELETE /users/sign_out(.:format)              sessions#destroy
#               user_password POST   /users/password(.:format)              devise/passwords#create
#           new_user_password GET    /users/password/new(.:format)          devise/passwords#new
#          edit_user_password GET    /users/password/edit(.:format)         devise/passwords#edit
#                             PUT    /users/password(.:format)              devise/passwords#update
#    cancel_user_registration GET    /users/cancel(.:format)                devise/registrations#cancel
#           user_registration POST   /users(.:format)                       devise/registrations#create
#       new_user_registration GET    /users/sign_up(.:format)               devise/registrations#new
#      edit_user_registration GET    /users/edit(.:format)                  devise/registrations#edit
#                             PUT    /users(.:format)                       devise/registrations#update
#                             DELETE /users(.:format)                       devise/registrations#destroy
#                       users GET    /users(.:format)                       users#index
#                        user GET    /users/:id(.:format)                   users#show
#                                    /*path(.:format)                       application#routing_error
#

Slooly::Application.routes.draw do
  resources :plans

  # resources :subscriptions
  
  resources :payment_notifications, controller: 'payment_notification',  only: [:create]
  
  resources :subscriptions, only: [:new, :create] do
    get :payment_plans, on: :collection
  end  
  
  resources :announcements

  resources :histories, only: :show

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

  resources :settings, only: [:index, :edit, :update]

  resources :clients do
    new do
     get :import_clients, :as => :import
    end

  end

  resources :companies, only: [:index, :edit, :update]

  resources :invoices

  match 'clients/import', as: :import, :via => :post
  

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
#  devise_for :users
  
  devise_for :users, controllers: {registrations: 'registrations',:sessions => "sessions"}
  resources :users, :only => [:show, :index]
  
  # Any other routes are handled here (as ActionDispatch prevents RoutingError from hitting ApplicationController::rescue_action).
  match "*path", :to => "application#routing_error"
end
