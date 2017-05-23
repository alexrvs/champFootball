Rails.application.routes.draw do

  # Front Pages
  root 'welcome#index'
  resources :welcome do
    get 'welcome/index'
  end
  resources :users
  resources :sessions, only: [:new, :create, :destroy, :createSocAuth]
  resources :user_ranks
  resources :teams do
    get 'teams', to: 'teams#index', via: 'get'
  end
  resources :tournaments do
    get '/tournaments', to: 'tournaments#index'
  end

  get '/signin', to: 'sessions#new'
  get '/signout', to: 'sessions#destroy'
  get '/signup', to: 'users#new', via: 'get'
  get 'auth/:provider/callback', to: 'sessions#createSocAuth'
  get 'auth/failure', to: redirect('/')
  get 'team/:id', to: 'teams#editTeamByUser'
  patch 'team/:id', to: 'teams#updateTeamByUser'
  get 'showTeam', to:'teams#showTeamCurrentUser'
  get '/rank', to: 'user_ranks#index'

  # Admin Panel

  namespace :admin do

    resources :users
    resources :sessions
    resources :tournaments
    resources :teams
    resources :tournament_types
    resources :matches
    resources :rounds
    resources :standings

    get '', to:  'base#index'
    get 'generate', to: 'teams#generate'
    get 'generate_matches', to: 'matches#index_generate'
    get 'generate_matches_round', to:'matches#generate'
    get 'close_vote', to:'teams#generate_rank_user', via:'get'
    post 'add_team_to_tournament', to:'tournaments#addTeamToTournament'

  end
end
