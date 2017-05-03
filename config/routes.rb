Rails.application.routes.draw do


  namespace :admin do
    get 'rounds/index'
  end

  namespace :admin do
    get 'rounds/show'
  end

  namespace :admin do
    get 'rounds/update'
  end

  namespace :admin do
    get 'rounds/edit'
  end

  namespace :admin do
    get 'rounds/delete'
  end

  get 'rounds/index'

  get 'rounds/edit'

  get 'rounds/delete'

  get 'rounds/update'

  get 'rounds/show'

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
    resources :tournament_types, path: 'admin/tournament_types'
    resources :matches, path: 'admin/matches'
    resources :rounds, path: 'admin/rounds'
    resources :standings, path: 'admin/standings'

    get 'tournaments', to: 'tournaments#index'
    get 'tournament_types', to: 'tournament_types#index'
    get '', to:  'base#index'
    get 'generate', to: 'teams#generate'
    get 'generate_matches', to: 'matches#index_generate'
    get 'generate_matches_round', to:'matches#generate'
  end
end
