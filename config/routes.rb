Rails.application.routes.draw do
  resources :tasks do
    collection do
      get :inbox
    end
  end
  resources :projects
  resources :contexts
end
