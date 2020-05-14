Rails.application.routes.draw do
  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: :about
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :users, :except => [:destroy, :new]
  resources :arts do
    resources :comments, only: [:create, :destroy]
    resource :likes, only: [:create, :destroy]
  end
  resources :exhibitions
  get 'exhibitions/:id/thanks' => 'exhibitions#thanks', as: :thanks
  delete 'cart_arts/empty' => 'cart_arts#empty', as: :empty
  resources :cart_arts, only: [:create, :destroy]
  resources :exhibition_arts, only: [:show, :create, :destroy ]
  resources :events
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
