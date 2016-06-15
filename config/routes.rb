DesignExchange::Application.routes.draw do

  get "collections/new"
  get "autocomplete_search", to: "application#search"

  resources :companies do 
    resources :contacts
  end
  
  resources :characteristics, only: [:show]

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

  #match "design_methods/:id", :via=>:post, :controller=>"pages", :action=>"create_collection"

  #resource :collection do
    # Route GET /user/admin_login
    #get 'add_method', :on => :collection
  #end

  get '/collections/add', to: 'collections#add', as: "add_to_collection"

  get '/design_methods/:id/remove', to: 'collections#remove'
  get '/case_studies/:id/remove', to: 'collections#remove'

  get '/collections/:id/edit/change_privacy', to: 'collections#change_privacy', as: "change_privacy"
  #get '/collections/:id/edit/remove', to: 'collections#remove', as: "remove_from_collection"
  #get '/collections/:id', to: 'collections#show'
  

  resources :method_categories, only: [:show]
  resources :citations, only: [:show]
  resources :feedbacks, only: [:create]


  resources :users do
    resources :design_methods, only: [:index]
  end

  resources :collections

  get 'search/(:query)', controller: 'design_methods', action: 'search', as: 'search'

  get ":action", to:"application##{:action}"


end
