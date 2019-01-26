Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'ranking#index'
  resource :search, only: [:create, :show], controller: 'search'
  resources :users, only: [:index, :show]
  resources :lines, only: [:index, :show]
  resource :crags, only: [:index, :show]
  resources :ascents, only: :index

  namespace :api do
    resource :places_autocomplete, only: :show, controller: "places_autocomplete"
  end
end
