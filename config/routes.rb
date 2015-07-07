DesignExchange::Application.routes.draw do
  get "autocomplete_search", to: "application#search"

  resources :companies do
    resources :contacts
  end

  resources :characteristics do
    resources :design_methods, only: [:index], shallow: true
  end

  resources :tags
  resources :method_case_studies
  root "application#index"

  case_studies = "studies"
  resources "#{case_studies}", as: :case_studies, controller: :case_studies do
    collection do
      get "related", to: "case_studies#related_methods"
      match "related_methods" => redirect("related"), via: [:get, :post]
      get "search/:query", to: "application#search"
      get "search", to: "application#search", :as => "search"
    end
    member do
      get "related", to: "case_studies#related_methods", :as => "related_methods"
      match "related_methods" => redirect("related"), via: [:get, :post]
    end
  end
  # TODO: legacy redirect; remove these eventually
  match "case_studies" => redirect("#{case_studies}"), via: [:get, :post]
  match "case_studies/:suffix" => redirect("#{case_studies}/%{suffix}"), via: [:get, :post]

  design_methods = "methods"
  resources "#{design_methods}", as: :design_methods, controller: :design_methods do
    collection do
      get "search/:query", to: "application#search"
      get "search", to: "application#search", :as => "search"
      get "method_category/:category_id",  to: "application#search", :as => "search_category"
    end
  end
  # TODO: legacy redirect; remove these eventually
  match "design_methods" => redirect("#{design_methods}"), via: [:get, :post]
  match "design_methods/:suffix" => redirect("#{design_methods}/%{suffix}"), via: [:get, :post]

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

  resources :method_categories, only: [:show]
  resources :citations, only: [:show]

  resources :users do
    resources :design_methods, only: [:index]
  end

  get 'search/(:query)', controller: 'design_methods', action: 'search', as: 'search'

  get ":action", to: "application##{:action}"
end
