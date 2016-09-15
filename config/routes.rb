DesignExchange::Application.routes.draw do

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
    end
    member do
      get "related_methods", to: "case_studies#related_methods", :as => "related_methods"
    end
  end

  resources :design_methods do
    collection do
      get "method_category/:category_id",  to: "application#search", :as => "search_category"
    end
  end

  get '/collections/add', to: 'collections#add', as: "add_to_collection"
  get '/collections/:id/edit/delete', to: 'collections#delete', as: "delete_collection"
  resources :collections

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  resources :drafts
  resources :method_categories, only: [:show]
  resources :citations, only: [:show]
  resources :feedbacks, only: [:create]
  resources :users

  # Singleton routes for admin panel
  get '/administrator', to: 'administrator#index'
  get '/administrator/change_admin', to: 'administrator#changeAdmin'
  get '/administrator/change_editor', to: 'administrator#changeEditor'
  get '/administrator/change_basic', to: 'administrator#changeBasic'
  get '/design_methods/:id/clearImage', to: 'design_methods#clearImage'
  get '/design_methods/new/clearImage', to: 'design_methods#clearImage'

  get ":action", to:"application##{:action}"
  post "search", to: "application#search"
  get "autocomplete_search", to: "application#search"

end
