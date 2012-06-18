Parolone::Application.routes.draw do
  get "sessions/create"

  get "sessions/destroy"

  get "sessions/index"

  get "welcome/index"
  
  match '/auth/:provider/callback', to: 'sessions#create', as: :login
  match '/signout', to: 'sessions#destroy', as: :logout

  root to: 'welcome#index'
end
