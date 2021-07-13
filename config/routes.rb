Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  root to: 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :homes, only: [:about]
  get '/homes/about', to: 'homes#about', as: 'about'
  resources :users, only: [:index, :edit, :show, :update] do
    get '/bookmarks', to: 'users#bookmarks', as: 'bookmarks'
  end
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
  end

  resources :items, only: [:index, :create, :update, :destroy]
  resources :shelters, only: [:create, :update, :destroy]
end
