Rails.application.routes.draw do
  namespace :v1 do
    resources :projects
    resources :people
    resources :clients
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
