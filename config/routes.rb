DesignExchange::Application.routes.draw do

  get "autocomplete_search", to: "application#search"

  resources :companies do
    resources :contacts
  end

  resources :characteristics
  resources :tags
  resources :method_case_studies
  root "application#index"

  resources :case_studies do
    collection do
      get "related_methods", to: "case_studies#related_methods"
      get "search/:query", to: "application#search"
      get "search", to: "application#search", :as => "search"
    end
    member do
      get "related_methods", to: "case_studies#related_methods", :as => "related_methods"
    end
  end

  resources :design_methods do
    collection do
      get "search/:query", to: "application#search"
      get "search", to: "application#search", :as => "search"
      get "method_category/:category_id",  to: "application#search", :as => "search_category"
    end
  end

  resources :discussions do
    collection do
      get "search/:query", to: "application#search"
      get "search", to: "application#search", :as => "search"
    end
  end

  resources :set do
    collection do
      get "search/:query", to: "application#search", :as => "search"
      get "search", to: "application#search"
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  get '/collections/add', to: 'collections#add', as: "add_to_collection"
  get '/collections/:id/edit/delete', to: 'collections#delete', as: "delete_collection"

  resources :method_categories, only: [:show]
  resources :citations, only: [:show]
  resources :feedbacks, only: [:create]
  resources :users
  resources :collections

  # Singleton routes for admin panel
  get '/administrator', to: 'administrator#index'
  get '/administrator/change_admin', to: 'administrator#changeAdmin'
  get '/administrator/change_editor', to: 'administrator#changeEditor'
  get '/administrator/change_basic', to: 'administrator#changeBasic'

  resources :collections

  get 'search/(:query)', controller: 'design_methods', action: 'search', as: 'search'
  get ":action", to:"application##{:action}"

end
