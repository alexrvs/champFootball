Rails.application.routes.draw do

  # Front Pages

  root 'welcome#index'
  resources :welcome do
    get 'welcome/index'
  end

  resources :users

  resources :sessions, only: [:new, :create, :destroy, :createSocAuth]

  get '/signin', to: 'sessions#new'
  get '/signout', to: 'sessions#destroy'
  get '/signup', to: 'users#new', via: 'get'
  get 'auth/:provider/callback', to: 'sessions#createSocAuth'

  resources :user_ranks do
    match '/rank', to: 'user_ranks#index', via: 'get'
  end

  resources :teams do
    get 'teams', to: 'teams#index', via: 'get'
  end

  get 'team/:id', to: 'teams#editTeamByUser'
  post 'team/:id', to: 'teams#updateTeamByUser'
  get 'showTeam', to:'teams#showTeamCurrentUser'

  resources :tournaments do
    get '/tournaments', to: 'tournaments#index'
  end

  match 'auth/failure', to: redirect('/'), via: 'get'


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
    get 'close_vote', to:'teams#generate_rank_user', via:'get'
    match 'add_team_to_tournament', to:'tournaments#addTeamToTournament', via: 'post'

  end
end
