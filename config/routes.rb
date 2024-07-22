Rails.application.routes.draw do
  devise_for :users
  resources :categories do
    collection do
      get 'tasks_for_today'
    end
    resources :tasks
  end

  get "up" => "rails/health#show", as: :rails_health_check
  root 'home#index'

  # Defines the root path route ("/")
  # root "posts#index"
end
