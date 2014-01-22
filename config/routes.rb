DesignExchange::Application.routes.draw do
  devise_for :users

  root to: "main_pages#home"

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
