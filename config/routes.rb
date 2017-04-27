Rails.application.routes.draw do


  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  get 'welcome/index'

  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Social Auth

  match 'auth/:provider/callback', to: 'sessions#createSocAuth', via: 'get'
  match 'auth/failure', to: redirect('/'), via: 'get'
  root 'welcome#index'

  # Admin Panel

  namespace :admin do
    resources :users, path: 'admin/users'
    resources :sessions
    resources :tournaments, path: 'admin/tournaments'
    resources :teams, path: 'admin/teams'
    resources :tournamenttypes, path: 'admin/tournamenttypes'

    get 'tournaments', to: 'tournaments#index'
    get '', to:  'base#index'
  end
end
