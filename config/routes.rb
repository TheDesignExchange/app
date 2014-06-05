DesignExchange::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  root "main_pages#home"

  get "collection/casestudies"
  get "collection/form"


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
