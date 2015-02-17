# == Route Map
#
#                      Prefix Verb   URI Pattern                                Controller#Action
#                       plans GET    /plans(.:format)                           plans#index
#                             POST   /plans(.:format)                           plans#create
#                    new_plan GET    /plans/new(.:format)                       plans#new
#                   edit_plan GET    /plans/:id/edit(.:format)                  plans#edit
#                        plan PATCH  /plans/:id(.:format)                       plans#update
#                             PUT    /plans/:id(.:format)                       plans#update
#                             DELETE /plans/:id(.:format)                       plans#destroy
#       payment_notifications POST   /payment_notifications(.:format)           payment_notification#create
# payment_plans_subscriptions GET    /subscriptions/payment_plans(.:format)     subscriptions#payment_plans
#               subscriptions POST   /subscriptions(.:format)                   subscriptions#create
#            new_subscription GET    /subscriptions/new(.:format)               subscriptions#new
#                     history GET    /histories/:id(.:format)                   histories#show
#                        home GET    /home(.:format)                            pages#home
#                       about GET    /about(.:format)                           pages#about
#                  ie_warning GET    /ie_warning(.:format)                      pages#ie_warning
#                         faq GET    /faq(.:format)                             pages#faq
#                        news GET    /news(.:format)                            pages#news
#                     reports GET    /reports(.:format)                         pages#reports
#               initial_setup GET    /initial_setup(.:format)                   pages#initial_setup
#                     pricing GET    /pricing(.:format)                         pages#pricing
#                         tos GET    /tos(.:format)                             pages#tos
#                    tutorial GET    /tutorial(.:format)                        pages#tutorial
#                     privacy GET    /privacy(.:format)                         pages#privacy
#             paypal_checkout GET    /paypal/checkout(.:format)                 subscriptions#paypal_checkout
#                    contacts POST   /contacts(.:format)                        contacts#create
#                 new_contact GET    /contacts/new(.:format)                    contacts#new
#                      redeem PATCH  /redeem(.:format)                          vouchers#redeem
#                    settings GET    /settings(.:format)                        settings#index
#                edit_setting GET    /settings/:id/edit(.:format)               settings#edit
#                     setting PATCH  /settings/:id(.:format)                    settings#update
#                             PUT    /settings/:id(.:format)                    settings#update
#             client_invoices POST   /clients/:client_id/invoices(.:format)     clients/invoices#create
#          new_client_invoice GET    /clients/:client_id/invoices/new(.:format) clients/invoices#new
#              search_clients GET    /clients/search(.:format)                  clients#search
#              exists_clients GET    /clients/exists(.:format)                  clients#exists
#                     clients GET    /clients(.:format)                         clients#index
#                             POST   /clients(.:format)                         clients#create
#                  new_client GET    /clients/new(.:format)                     clients#new
#                 edit_client GET    /clients/:id/edit(.:format)                clients#edit
#                      client GET    /clients/:id(.:format)                     clients#show
#                             PATCH  /clients/:id(.:format)                     clients#update
#                             PUT    /clients/:id(.:format)                     clients#update
#                             DELETE /clients/:id(.:format)                     clients#destroy
#             clients_imports POST   /clients/imports(.:format)                 clients/imports#create
#          new_clients_import GET    /clients/imports/new(.:format)             clients/imports#new
#                edit_company GET    /company/edit(.:format)                    companies#edit
#                     company GET    /company(.:format)                         companies#show
#                             PATCH  /company(.:format)                         companies#update
#                             PUT    /company(.:format)                         companies#update
#             search_invoices GET    /invoices/search(.:format)                 invoices#search
#                    invoices GET    /invoices(.:format)                        invoices#index
#                             POST   /invoices(.:format)                        invoices#create
#                 new_invoice GET    /invoices/new(.:format)                    invoices#new
#                edit_invoice GET    /invoices/:id/edit(.:format)               invoices#edit
#                     invoice GET    /invoices/:id(.:format)                    invoices#show
#                             PATCH  /invoices/:id(.:format)                    invoices#update
#                             PUT    /invoices/:id(.:format)                    invoices#update
#                             DELETE /invoices/:id(.:format)                    invoices#destroy
#             dashboard_index GET    /dashboard(.:format)                       dashboard#index
#       admin_dashboard_index GET    /admin/dashboard(.:format)                 admin/dashboard#index
#           admin_suggestions GET    /admin/suggestions(.:format)               admin/suggestions#index
#            admin_suggestion DELETE /admin/suggestions/:id(.:format)           admin/suggestions#destroy
#         admin_announcements GET    /admin/announcements(.:format)             admin/announcements#index
#                             POST   /admin/announcements(.:format)             admin/announcements#create
#      new_admin_announcement GET    /admin/announcements/new(.:format)         admin/announcements#new
#     edit_admin_announcement GET    /admin/announcements/:id/edit(.:format)    admin/announcements#edit
#          admin_announcement GET    /admin/announcements/:id(.:format)         admin/announcements#show
#                             PATCH  /admin/announcements/:id(.:format)         admin/announcements#update
#                             PUT    /admin/announcements/:id(.:format)         admin/announcements#update
#                             DELETE /admin/announcements/:id(.:format)         admin/announcements#destroy
#                  admin_root GET    /                                          admin/dashboard#index
#          authenticated_root GET    /                                          dashboard#index
#                        root GET    /                                          home#index
#            new_user_session GET    /users/sign_in(.:format)                   sessions#new
#                user_session POST   /users/sign_in(.:format)                   sessions#create
#        destroy_user_session DELETE /users/sign_out(.:format)                  sessions#destroy
#               user_password POST   /users/password(.:format)                  devise/passwords#create
#           new_user_password GET    /users/password/new(.:format)              devise/passwords#new
#          edit_user_password GET    /users/password/edit(.:format)             devise/passwords#edit
#                             PATCH  /users/password(.:format)                  devise/passwords#update
#                             PUT    /users/password(.:format)                  devise/passwords#update
#    cancel_user_registration GET    /users/cancel(.:format)                    registrations#cancel
#           user_registration POST   /users(.:format)                           registrations#create
#       new_user_registration GET    /users/sign_up(.:format)                   registrations#new
#      edit_user_registration GET    /users/edit(.:format)                      registrations#edit
#                             PATCH  /users(.:format)                           registrations#update
#                             PUT    /users(.:format)                           registrations#update
#                             DELETE /users(.:format)                           registrations#destroy
#                        user GET    /users/:id(.:format)                       users#show
#               announcements GET    /announcements(.:format)                   announcements#index
#                announcement GET    /announcements/:id(.:format)               announcements#show
#              new_suggestion GET    /suggestions/new(.:format)                 suggestions#new
#                  suggestion PATCH  /suggestions/:id(.:format)                 suggestions#update
#                             PUT    /suggestions/:id(.:format)                 suggestions#update
#                                    (/errors)/:status(.:format)                errors#show {:status=>/\d{3}/}
#

Slooly::Application.routes.draw do

  authenticated :user, lambda { |u| u.admin? } do
    namespace :admin do
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

    root to: "admin/dashboard#index", as: :admin_root
  end

  authenticated :user do
    root to: 'dashboard#index', as: :authenticated_root
  end
  root to: "home#index"

  resources :dashboard, only: :index

  devise_for :users, controllers: {registrations: 'registrations', sessions: "sessions"}

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
