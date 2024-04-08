Rails.application.routes.draw do
  resources :memberships


  resources :posts do
    member do
      post 'upvote'
      post 'downvote'
      post 'create_comment'

    end
  end
  devise_for :users
  resources :subreddits do 
    collection do 
      post :search
    end

    member do
      post 'join'
    end
  end

  get 'my_subreddits', to: 'subreddits#my_subreddits', as: 'my_subreddits'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "subreddits#index"
end
