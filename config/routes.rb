Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: :index
  resources :lines, only: :index
  resources :ascents, only: :index
end
