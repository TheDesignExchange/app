DesignExchange::Application.routes.draw do
  resources :method_case_studies
  
  root "de#index"
  

  get "de/index"
  get "de/search"

  get "methods/:action/:id", to: "methods##{:action}"
  get "methods/:action/", to: "methods##{:action}"
  

  get "case_studies/home"
  get "case_studies/create"
  get "case_studies/view"
  get "case_studies/search"
  get "case_studies/edit"

  get "discussions/home"
  get "discussions/create"
  get "discussions/view"
  get "discussions/search"



  get "account/profile_user"
  get "account/profile_user_edit"
  get "account/account_information"
  get "account/login"
  get "account/register"

  get "set/home"
  get "set/create"
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users



  get "collection/casestudies"
  get "collection/form"
  get "collection/linkmethods"
  get "collection/autocomplete_design_methods"
  post "collection/linkmethod"
  delete "collection/removemethod"
  get "collection/links"


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
