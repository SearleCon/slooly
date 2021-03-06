# == Route Map
#
#                        Prefix Verb   URI Pattern                                             Controller#Action
#                   admins_home GET    /admins(.:format)                                       redirect(301, /admins/sign_in)
#             new_admin_session GET    /admins/sign_in(.:format)                               admins/sessions#new
#                 admin_session POST   /admins/sign_in(.:format)                               admins/sessions#create
#         destroy_admin_session DELETE /admins/sign_out(.:format)                              admins/sessions#destroy
#        admins_dashboard_index GET    /admins/dashboard(.:format)                             admins/dashboard#index
#            admins_suggestions GET    /admins/suggestions(.:format)                           admins/suggestions#index
#             admins_suggestion DELETE /admins/suggestions/:id(.:format)                       admins/suggestions#destroy
#          admins_announcements GET    /admins/announcements(.:format)                         admins/announcements#index
#                               POST   /admins/announcements(.:format)                         admins/announcements#create
#       new_admins_announcement GET    /admins/announcements/new(.:format)                     admins/announcements#new
#      edit_admins_announcement GET    /admins/announcements/:id/edit(.:format)                admins/announcements#edit
#           admins_announcement PATCH  /admins/announcements/:id(.:format)                     admins/announcements#update
#                               PUT    /admins/announcements/:id(.:format)                     admins/announcements#update
#                               DELETE /admins/announcements/:id(.:format)                     admins/announcements#destroy
#                  admins_plans GET    /admins/plans(.:format)                                 admins/plans#index
#                               POST   /admins/plans(.:format)                                 admins/plans#create
#               new_admins_plan GET    /admins/plans/new(.:format)                             admins/plans#new
#              edit_admins_plan GET    /admins/plans/:id/edit(.:format)                        admins/plans#edit
#                   admins_plan PATCH  /admins/plans/:id(.:format)                             admins/plans#update
#                               PUT    /admins/plans/:id(.:format)                             admins/plans#update
#                               DELETE /admins/plans/:id(.:format)                             admins/plans#destroy
# edit_admins_user_subscription GET    /admins/users/:user_id/subscriptions/:id/edit(.:format) admins/users/subscriptions#edit
#      admins_user_subscription PATCH  /admins/users/:user_id/subscriptions/:id(.:format)      admins/users/subscriptions#update
#                               PUT    /admins/users/:user_id/subscriptions/:id(.:format)      admins/users/subscriptions#update
#                  admins_users GET    /admins/users(.:format)                                 admins/users#index
#                   admins_user GET    /admins/users/:id(.:format)                             admins/users#show
#            admins_delayed_web        /admins/jobs                                            Delayed::Web::Engine
#                    admin_root GET    /                                                       admins/dashboard#index
#              new_user_session GET    /users/sign_in(.:format)                                sessions#new
#                  user_session POST   /users/sign_in(.:format)                                sessions#create
#          destroy_user_session DELETE /users/sign_out(.:format)                               sessions#destroy
#                 user_password POST   /users/password(.:format)                               devise/passwords#create
#             new_user_password GET    /users/password/new(.:format)                           devise/passwords#new
#            edit_user_password GET    /users/password/edit(.:format)                          devise/passwords#edit
#                               PATCH  /users/password(.:format)                               devise/passwords#update
#                               PUT    /users/password(.:format)                               devise/passwords#update
#      cancel_user_registration GET    /users/cancel(.:format)                                 registrations#cancel
#             user_registration POST   /users(.:format)                                        registrations#create
#         new_user_registration GET    /users/sign_up(.:format)                                registrations#new
#        edit_user_registration GET    /users/edit(.:format)                                   registrations#edit
#                               PATCH  /users(.:format)                                        registrations#update
#                               PUT    /users(.:format)                                        registrations#update
#                               DELETE /users(.:format)                                        registrations#destroy
#                     user_root GET    /                                                       dashboard#index
#               client_invoices POST   /clients/:client_id/invoices(.:format)                  clients/invoices#create
#            new_client_invoice GET    /clients/:client_id/invoices/new(.:format)              clients/invoices#new
#                       clients GET    /clients(.:format)                                      clients#index
#                               POST   /clients(.:format)                                      clients#create
#                    new_client GET    /clients/new(.:format)                                  clients#new
#                   edit_client GET    /clients/:id/edit(.:format)                             clients#edit
#                        client GET    /clients/:id(.:format)                                  clients#show
#                               PATCH  /clients/:id(.:format)                                  clients#update
#                               PUT    /clients/:id(.:format)                                  clients#update
#                               DELETE /clients/:id(.:format)                                  clients#destroy
#               clients_imports POST   /clients/imports(.:format)                              clients/imports#create
#            new_clients_import GET    /clients/imports/new(.:format)                          clients/imports#new
#                  edit_company GET    /company/edit(.:format)                                 companies#edit
#                       company GET    /company(.:format)                                      companies#show
#                               PATCH  /company(.:format)                                      companies#update
#                               PUT    /company(.:format)                                      companies#update
#               dashboard_index GET    /dashboard(.:format)                                    dashboard#index
#                      invoices GET    /invoices(.:format)                                     invoices#index
#                               POST   /invoices(.:format)                                     invoices#create
#                   new_invoice GET    /invoices/new(.:format)                                 invoices#new
#                  edit_invoice GET    /invoices/:id/edit(.:format)                            invoices#edit
#                       invoice GET    /invoices/:id(.:format)                                 invoices#show
#                               PATCH  /invoices/:id(.:format)                                 invoices#update
#                               PUT    /invoices/:id(.:format)                                 invoices#update
#                               DELETE /invoices/:id(.:format)                                 invoices#destroy
#                       history GET    /histories/:id(.:format)                                histories#show
#                        redeem PATCH  /redeem(.:format)                                       vouchers#redeem
#                 edit_settings GET    /settings/edit(.:format)                                settings#edit
#                      settings GET    /settings(.:format)                                     settings#show
#                               PATCH  /settings(.:format)                                     settings#update
#                               PUT    /settings(.:format)                                     settings#update
#                          root GET    /                                                       home#index
#                impersonations POST   /impersonations(.:format)                               impersonations#create
#                 impersonation DELETE /impersonations/:id(.:format)                           impersonations#destroy
#             hide_announcement GET    /announcements/:id/hide(.:format)                       announcements#hide
#                 announcements GET    /announcements(.:format)                                announcements#index
#                         plans GET    /plans(.:format)                                        plans#index
#              paypal_checkouts POST   /paypal/checkouts(.:format)                             paypal/checkouts#create
#                 subscriptions POST   /subscriptions(.:format)                                subscriptions#create
#              new_subscription GET    /subscriptions/new(.:format)                            subscriptions#new
#                       reports GET    /reports(.:format)                                      reports#index
#                 welcome_index GET    /welcome(.:format)                                      welcome#index
#                   suggestions POST   /suggestions(.:format)                                  suggestions#create
#                new_suggestion GET    /suggestions/new(.:format)                              suggestions#new
#                         about GET    /about(.:format)                                        pages#about
#            supported_browsers GET    /supported_browsers(.:format)                           pages#supported_browsers
#                           faq GET    /faq(.:format)                                          pages#faq
#                       pricing GET    /pricing(.:format)                                      pages#pricing
#                           tos GET    /tos(.:format)                                          pages#tos
#                      tutorial GET    /tutorial(.:format)                                     pages#tutorial
#                       privacy GET    /privacy(.:format)                                      pages#privacy
#                      contacts POST   /contacts(.:format)                                     contacts#create
#                   new_contact GET    /contacts/new(.:format)                                 contacts#new
#                                      (/errors)/:status(.:format)                             errors#show {:status=>/\d{3}/}
#
# Routes for Delayed::Web::Engine:
#      root GET    /                         delayed/web/jobs#index
# queue_job PUT    /jobs/:id/queue(.:format) delayed/web/jobs#queue
#      jobs GET    /jobs(.:format)           delayed/web/jobs#index
#       job GET    /jobs/:id(.:format)       delayed/web/jobs#show
#           DELETE /jobs/:id(.:format)       delayed/web/jobs#destroy
#

Rails.application.routes.draw do
  # Admin
  get '/admins', to: redirect('/admins/sign_in'), as: :admins_home

  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  authenticated :admin do
    namespace :admins do
      resources :dashboard, only: :index
      resources :suggestions, only: [:index, :destroy]
      resources :announcements, except: :show
      resources :plans, except: :show
      resources :users, only: [:index, :show] do
        resources :subscriptions, only: [:edit, :update], controller: 'users/subscriptions'
      end

      mount Delayed::Web::Engine, at: '/jobs'
    end

    root to: 'admins/dashboard#index', as: :admin_root
  end

  # Users

  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }

  authenticated :user do
    root to: 'dashboard#index', as: :user_root
  end

  resources :clients do
    resources :invoices, only: [:new, :create, :destroy], controller: 'clients/invoices'
  end

  namespace :clients do
    resources :imports, only: [:new, :create]
  end

  resource :company, only: [:show, :edit, :update]

  resources :dashboard, only: :index

  resources :invoices

  resources :histories, only: :show

  match 'redeem' => 'vouchers#redeem', as: 'redeem', via: :patch

  resource :settings, only: [:show, :edit, :update]
  root to: 'home#index'

  resources :impersonations, only: [:create, :destroy]

  resources :announcements, only: [:index] do
    get :hide, on: :member
  end

  resources :plans, only: :index

  namespace :paypal do
    resources :checkouts, only: :create
  end

  resources :subscriptions, only: [:new, :create]

  resources :reports, only: :index
  resources :welcome, only: :index

  # Public
  resources :suggestions, only: [:new, :create]

  controller :pages do
    get :about
    get :supported_browsers
    get :faq
    get :pricing
    get :tos
    get :tutorial
    get :privacy
  end

  resources :contacts, only: [:new, :create]

  # Errors
  match '(errors)/:status', to: 'errors#show', constraints: { status: /\d{3}/ }, via: :all
end
