Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'ranking#index'
  resources :users, only: [:index, :show]
  resources :lines, only: [:index, :show]
  resource :crags, only: [:index, :show]
  resources :ascents, only: :index
end
