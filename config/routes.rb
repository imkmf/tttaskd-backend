Rails.application.routes.draw do
  devise_for :users
  resources :tasks do
    collection do
      get :inbox
      get :flagged
    end
  end

  resources :projects
  resources :contexts

  get 'ok' => 'authentication#ok'
  post '/auth_user' => 'authentication#authenticate_user'
  post '/auth/sign_up' => 'authentication#sign_up'

  root to: 'pages#root'
  get '/.well-known/acme-challenge/:id' => 'pages#letsencrypt'
end
