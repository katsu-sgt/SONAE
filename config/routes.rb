Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :homes, only: [:about]
  resources :users, only: [:index, :edit, :show, :update]
  resources :posts
  resources :items, only: [:index, :create, :update, :destroy]
  resources :shelters, only: [:create, :update, :destroy]
end
