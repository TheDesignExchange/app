DesignExchange::Application.routes.draw do
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'


  # resources :method_case_studies
  # resources :case_studies

  get "de/index"
  get "de/search"

  get "methods/home"
  get "methods/create"
  get "methods/view"
  get "methods/search"

  get "case_studies/home"
  get "case_studies/create"
  get "case_studies/view"
  get "case_studies/search"

  get "discussions/home"
  get "discussions/create"
  get "discussions/view"
  get "discussions/search"

  get "account/profile_user"
  get "account/settings"
  get "account/login"
  get "account/register"

  get "set/home"
  get "set/create"
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root "de#index"

  get "collection/casestudies"
  get "collection/form"
  get "collection/styletest"
  get "collection/linkmethods"


  post "collection/send_casestudy"


  get :about, to: "main_pages#about"

  get :contact, to: "main_pages#contact"

  resources :design_methods do
    get :autocomplete, on: :collection
  end

  resources :method_categories, only: [:show]
  resources :citations, only: [:show]
  resources :users do
    resources :design_methods, only: [:index]
  end
  get 'search/(:query)', controller: 'design_methods', action: 'search', as: 'search'
end
