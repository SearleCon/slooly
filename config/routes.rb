# == Route Map
#
#                        Prefix Verb   URI Pattern                                             Controller#Action
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
#              queue_admins_job PATCH  /admins/jobs/:id/queue(.:format)                        admins/jobs#queue
#                   admins_jobs GET    /admins/jobs(.:format)                                  admins/jobs#index
#                    admins_job DELETE /admins/jobs/:id(.:format)                              admins/jobs#destroy
#                    admin_root GET    /                                                       admins/dashboard#index
#                   admins_home GET    /admins(.:format)                                       redirect(301, /admins/sign_in)
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
#                          root GET    /                                                       home#index
#               dashboard_index GET    /dashboard(.:format)                                    dashboard#index
#               search_invoices GET    /invoices/search(.:format)                              invoices#search
#                      invoices GET    /invoices(.:format)                                     invoices#index
#                               POST   /invoices(.:format)                                     invoices#create
#                   new_invoice GET    /invoices/new(.:format)                                 invoices#new
#                  edit_invoice GET    /invoices/:id/edit(.:format)                            invoices#edit
#                       invoice GET    /invoices/:id(.:format)                                 invoices#show
#                               PATCH  /invoices/:id(.:format)                                 invoices#update
#                               PUT    /invoices/:id(.:format)                                 invoices#update
#                               DELETE /invoices/:id(.:format)                                 invoices#destroy
#                impersonations POST   /impersonations(.:format)                               impersonations#create
#                 impersonation DELETE /impersonations/:id(.:format)                           impersonations#destroy
#                 announcements GET    /announcements(.:format)                                announcements#index
#                   suggestions POST   /suggestions(.:format)                                  suggestions#create
#                new_suggestion GET    /suggestions/new(.:format)                              suggestions#new
#         payment_notifications POST   /payment_notifications(.:format)                        payment_notification#create
#   payment_plans_subscriptions GET    /subscriptions/payment_plans(.:format)                  subscriptions#payment_plans
#                 subscriptions POST   /subscriptions(.:format)                                subscriptions#create
#              new_subscription GET    /subscriptions/new(.:format)                            subscriptions#new
#                       history GET    /histories/:id(.:format)                                histories#show
#                          home GET    /home(.:format)                                         pages#home
#                         about GET    /about(.:format)                                        pages#about
#                    ie_warning GET    /ie_warning(.:format)                                   pages#ie_warning
#                           faq GET    /faq(.:format)                                          pages#faq
#                          news GET    /news(.:format)                                         pages#news
#                       reports GET    /reports(.:format)                                      pages#reports
#                 initial_setup GET    /initial_setup(.:format)                                pages#initial_setup
#                       pricing GET    /pricing(.:format)                                      pages#pricing
#                           tos GET    /tos(.:format)                                          pages#tos
#                      tutorial GET    /tutorial(.:format)                                     pages#tutorial
#                       privacy GET    /privacy(.:format)                                      pages#privacy
#               paypal_checkout GET    /paypal/checkout(.:format)                              subscriptions#paypal_checkout
#                      contacts POST   /contacts(.:format)                                     contacts#create
#                   new_contact GET    /contacts/new(.:format)                                 contacts#new
#                        redeem PATCH  /redeem(.:format)                                       vouchers#redeem
#                      settings GET    /settings(.:format)                                     settings#index
#                  edit_setting GET    /settings/:id/edit(.:format)                            settings#edit
#                       setting PATCH  /settings/:id(.:format)                                 settings#update
#                               PUT    /settings/:id(.:format)                                 settings#update
#               client_invoices POST   /clients/:client_id/invoices(.:format)                  clients/invoices#create
#            new_client_invoice GET    /clients/:client_id/invoices/new(.:format)              clients/invoices#new
#                search_clients GET    /clients/search(.:format)                               clients#search
#                exists_clients GET    /clients/exists(.:format)                               clients#exists
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
#                                      (/errors)/:status(.:format)                             errors#show {:status=>/\d{3}/}
#

Slooly::Application.routes.draw do

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
      resources :jobs, only: [:index, :destroy] do
        member do
          patch :queue
        end
      end
    end

    root to: "admins/dashboard#index", as: :admin_root
  end

  get '/admins', to: redirect('/admins/sign_in'), as: :admins_home



  devise_for :users, controllers: {registrations: 'registrations', sessions: "sessions"}
  authenticated :user do
    root to: 'dashboard#index', as: :user_root
  end
  root to: "home#index"

  resources :dashboard, only: :index

  resources :invoices do
    collection do
      get :search
    end
  end

  resources :impersonations, only: [:create, :destroy]


  resources :announcements, only: [:index]

  resources :suggestions, only: [:new, :create]

  resources :payment_notifications, controller: 'payment_notification',  only: [:create]

  resources :subscriptions, only: [:new, :create] do
    get :payment_plans, on: :collection
  end

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

  resources :contacts, only: [:new, :create]

  match 'redeem' => 'vouchers#redeem', as: 'redeem', via: :patch

  resources :settings, only: [:index, :edit, :update]

  resources :clients do
    resources :invoices, only: [:new, :create], controller: 'clients/invoices'
    collection do
      get :search
      get :exists
    end
  end

  namespace :clients do
    resources :imports, only: [:new, :create]
  end

  resource :company, only: [:show, :edit, :update]

  match '(errors)/:status', to: 'errors#show', constraints: { status: /\d{3}/ }, via: :all
end
