Rails.application.routes.draw do
  namespace :v1 do
    resources :projects
    resources :people
    resources :clients
    resources :tasks
  end
end
