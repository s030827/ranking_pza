Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show]
  resources :lines, only: [:index, :show]
  resource :crags, only: [:index, :show]
  resources :ascents, only: :index
end
