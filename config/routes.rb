DesignExchange::Application.routes.draw do
  resources :method_case_studies
  
  root "application#index"

  resources :set 

  resources :case_studies do
    collection do 
      get "search/:query", to: "application#search", :as => "search"
      get "search", to: "application#search"
    end
  end

  resources :discussions do
    collection do 
      get "search/:query", to: "application#search", :as => "search"
      get "search", to: "application#search"
    end
  end

  get "account/profile_user"
  get "account/profile_user_edit"
  get "account/account_information"
  get "account/login"
  get "account/register"

  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  get :action, to:"application##{:action}"

  resources :design_methods do
    get :autocomplete, on: :collection
    get :search
  end

  resources :method_categories, only: [:show]
  resources :citations, only: [:show]

  resources :users do
    resources :design_methods, only: [:index]
  end

  get 'search/(:query)', controller: 'case_studies', action: 'search', as: 'search'
end
