# == Route Map
#
#                      Prefix Verb   URI Pattern                            Controller#Action
#                       plans GET    /plans(.:format)                       plans#index
#                             POST   /plans(.:format)                       plans#create
#                    new_plan GET    /plans/new(.:format)                   plans#new
#                   edit_plan GET    /plans/:id/edit(.:format)              plans#edit
#                        plan GET    /plans/:id(.:format)                   plans#show
#                             PATCH  /plans/:id(.:format)                   plans#update
#                             PUT    /plans/:id(.:format)                   plans#update
#                             DELETE /plans/:id(.:format)                   plans#destroy
#       payment_notifications POST   /payment_notifications(.:format)       payment_notification#create
# payment_plans_subscriptions GET    /subscriptions/payment_plans(.:format) subscriptions#payment_plans
#               subscriptions POST   /subscriptions(.:format)               subscriptions#create
#            new_subscription GET    /subscriptions/new(.:format)           subscriptions#new
#               announcements GET    /announcements(.:format)               announcements#index
#                             POST   /announcements(.:format)               announcements#create
#            new_announcement GET    /announcements/new(.:format)           announcements#new
#           edit_announcement GET    /announcements/:id/edit(.:format)      announcements#edit
#                announcement GET    /announcements/:id(.:format)           announcements#show
#                             PATCH  /announcements/:id(.:format)           announcements#update
#                             PUT    /announcements/:id(.:format)           announcements#update
#                             DELETE /announcements/:id(.:format)           announcements#destroy
#                     history GET    /histories/:id(.:format)               histories#show
#                        home GET    /home(.:format)                        pages#home
#                       about GET    /about(.:format)                       pages#about
#                  ie_warning GET    /ie_warning(.:format)                  pages#ie_warning
#                         faq GET    /faq(.:format)                         pages#faq
#                        news GET    /news(.:format)                        pages#news
#                     reports GET    /reports(.:format)                     pages#reports
#               initial_setup GET    /initial_setup(.:format)               pages#initial_setup
#                     pricing GET    /pricing(.:format)                     pages#pricing
#                         tos GET    /tos(.:format)                         pages#tos
#                    tutorial GET    /tutorial(.:format)                    pages#tutorial
#                     privacy GET    /privacy(.:format)                     pages#privacy
#             paypal_checkout GET    /paypal/checkout(.:format)             subscriptions#paypal_checkout
#                 new_contact GET    /contact(.:format)                     contact#new
#                     contact POST   /contact(.:format)                     contact#create
#                      redeem PATCH  /redeem(.:format)                      vouchers#redeem
#                 suggestions GET    /suggestions(.:format)                 suggestions#index
#                             POST   /suggestions(.:format)                 suggestions#create
#              new_suggestion GET    /suggestions/new(.:format)             suggestions#new
#             edit_suggestion GET    /suggestions/:id/edit(.:format)        suggestions#edit
#                  suggestion GET    /suggestions/:id(.:format)             suggestions#show
#                             PATCH  /suggestions/:id(.:format)             suggestions#update
#                             PUT    /suggestions/:id(.:format)             suggestions#update
#                             DELETE /suggestions/:id(.:format)             suggestions#destroy
#                    settings GET    /settings(.:format)                    settings#index
#                edit_setting GET    /settings/:id/edit(.:format)           settings#edit
#                     setting PATCH  /settings/:id(.:format)                settings#update
#                             PUT    /settings/:id(.:format)                settings#update
#                     clients GET    /clients(.:format)                     clients#index
#                             POST   /clients(.:format)                     clients#create
#                  new_client GET    /clients/new(.:format)                 clients#new
#                 edit_client GET    /clients/:id/edit(.:format)            clients#edit
#                      client GET    /clients/:id(.:format)                 clients#show
#                             PATCH  /clients/:id(.:format)                 clients#update
#                             PUT    /clients/:id(.:format)                 clients#update
#                             DELETE /clients/:id(.:format)                 clients#destroy
#                   companies GET    /companies(.:format)                   companies#index
#                edit_company GET    /companies/:id/edit(.:format)          companies#edit
#                     company PATCH  /companies/:id(.:format)               companies#update
#                             PUT    /companies/:id(.:format)               companies#update
#                    invoices GET    /invoices(.:format)                    invoices#index
#                             POST   /invoices(.:format)                    invoices#create
#                 new_invoice GET    /invoices/new(.:format)                invoices#new
#                edit_invoice GET    /invoices/:id/edit(.:format)           invoices#edit
#                     invoice GET    /invoices/:id(.:format)                invoices#show
#                             PATCH  /invoices/:id(.:format)                invoices#update
#                             PUT    /invoices/:id(.:format)                invoices#update
#                             DELETE /invoices/:id(.:format)                invoices#destroy
#          authenticated_root GET    /                                      pages#home
#                        root GET    /                                      home#index
#            new_user_session GET    /users/sign_in(.:format)               sessions#new
#                user_session POST   /users/sign_in(.:format)               sessions#create
#        destroy_user_session DELETE /users/sign_out(.:format)              sessions#destroy
#               user_password POST   /users/password(.:format)              devise/passwords#create
#           new_user_password GET    /users/password/new(.:format)          devise/passwords#new
#          edit_user_password GET    /users/password/edit(.:format)         devise/passwords#edit
#                             PATCH  /users/password(.:format)              devise/passwords#update
#                             PUT    /users/password(.:format)              devise/passwords#update
#    cancel_user_registration GET    /users/cancel(.:format)                registrations#cancel
#           user_registration POST   /users(.:format)                       registrations#create
#       new_user_registration GET    /users/sign_up(.:format)               registrations#new
#      edit_user_registration GET    /users/edit(.:format)                  registrations#edit
#                             PATCH  /users(.:format)                       registrations#update
#                             PUT    /users(.:format)                       registrations#update
#                             DELETE /users(.:format)                       registrations#destroy
#                       users GET    /users(.:format)                       users#index
#                        user GET    /users/:id(.:format)                   users#show
#                                    /*path(.:format)                       application#routing_error
#

Slooly::Application.routes.draw do
  resources :plans

  resources :payment_notifications, controller: 'payment_notification',  only: [:create]

  resources :subscriptions, only: [:new, :create] do
    get :payment_plans, on: :collection
  end

  resources :announcements

  resources :histories, only: :show

  controller :pages do
    get :home
    get :about
    get :ie_warning
    get :faq
    get :news
    get :reports
    get :initial_setup
    get :pricing
    get :tos
    get :tutorial
    get :privacy

  end

  get "paypal/checkout", to: "subscriptions#paypal_checkout"

  match 'contact' => 'contact#new', as: 'new_contact', via: :get
  match 'contact' => 'contact#create', :as => 'contact', via: :post

  match 'redeem' => 'vouchers#redeem', :as => 'redeem', via: :patch

  resources :suggestions

  resources :settings, only: [:index, :edit, :update]

  resources :clients do
    collection do
      post :import
    end
  end

  resources :companies, only: [:index, :edit, :update]

  resources :invoices



  authenticated :user do
    root to: 'pages#home', as: :authenticated_root
  end
  root to: "home#index"

  devise_for :users, controllers: {registrations: 'registrations',sessions: "sessions"}
  resources :users, only: [:show, :index]
end
