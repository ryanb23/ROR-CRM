Rails.application.routes.draw do

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  resources :payments
  concern :searchable do
    collection do
      get 'search'
    end
  end
  namespace :admin do
    resources :bank_accounts
    resources :companies
    resources :equipment
    resources :equipment_brands
    resources :equipment_models,concerns: [:searchable]
    resources :equipment_types
    resources :establishment_services
    resources :establishments
    resources :invoices_patients,concerns: [:searchable]
    resources :plans
    resources :positions
    resources :permissions
    resources :roles
    resources :skills
    resources :user_skills, only: [:show,:destroy]
    resources :specialities
    resources :forms
    resources :insurance_files, only: [:show,:destroy]
    resources :patients
    resources :patient_draft_data do
      collection do
        post 'save_upload_file', to: 'patient_draft_data/save_upload_file'
      end
    end
    resources :settings do
      collection do
        put 'update_settings',to: 'settings/update_settings'
      end
    end
    resources :users,concerns: [:searchable] do
      collection do
        get "pre_creation_user", to: 'users#pre_creation_user', :as => "pre_creation_user"
        get "accounts_to_active", to: 'users#accounts_to_active', :as => "accounts_to_active"
        get "pending_accounts", to: 'users#pending_accounts', :as => "pending_accounts"
        get "active_accounts", to: 'users#active_accounts', :as => "active_accounts"
        get "deactive_accounts", to: 'users#deactive_accounts', :as => "deactive_accounts"
        get "get_del_cust_by_country", to: 'users#get_del_cust_by_country', :as => "get_del_cust_by_country"
        get "set_current_role", to: 'users#set_current_role', :as => "set_current_role"
      end
      member do
        get "show_signature", to: 'users#show_signature', :as => "show_signature"
        put "delete_signature", to: 'users#delete_signature', :as => "delete_signature"
        get "active_account_form", to: 'users#active_account_form', :as => "active_account_form"
        post "update_account_status", to: 'users#update_account_status'
      end
    end
    # resources :users
    post "users/checkpostalcode", to: 'users#checkpostalcode', :as => "checkpostalcode"
    get "users/approved_data",to: 'users#approved_data', :as =>"approved_data"
    # get "users/pre_creation_user", to: 'users#pre_creation_user', :as => "pre_creation_user"
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    password_expired: 'users/password_expired'

  }
  devise_scope :user do
    get 'signup' => 'users/registrations#new', :as => :sign_up
    # post 'signup' => 'users/registrations#new', :as => :sign_up
    authenticated :user do
      root 'dashboard#show'
    end
    get 'users/password_expired/change_password'
    post 'users/password_expired/update_password'

  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "devise/sessions#new"
  # root 'home#index'
  # resources "users"
  post '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale
  post '/set_role', to: 'settings#set_role_before_sign_up', as: :set_role_before_sign_up
  get '/get_users', to: 'settings#get_users'
  get '/find_customer_id', to: 'settings#find_customer_id'
  get '/find_patient_id', to: 'settings#find_patient_id'
  get '/find_provider_id', to: 'settings#find_provider_id'
  get '/find_delegate_customer_id', to: 'settings#find_delegate_customer_id'
  get '/find_salesman_before_sale_id', to: 'settings#find_salesman_before_sale_id'
  get '/find_salesman_sav_id', to: 'settings#find_salesman_sav_id'
  get '/find_physician_id', to: 'settings#find_physician_id'
  get '/get_all_skills', to: 'settings#get_all_skills'
  get '/mark_notification_as_read', to: 'settings#mark_notification_as_read'
  resources :forms do
    member do 
      get ':form_name' => "forms#payment_of_analysis", as: :payment_of_analysis
    end
  end

  resources :establishments, only: [:index]
  resources :establishment_services, only: [:index]
  resources :role_selection,only: [:index]
  post 'role_selection/get_role_id'
  get '/admin/establishment_form_check_postal_code', to: 'settings#establishment_form_check_postal_code'
  get '/admin/new_user_form_check_postal_code', to: 'settings#new_user_form_check_postal_code'
  get '/admin/change_notification_value', to: 'settings#change_notification_value'
end
