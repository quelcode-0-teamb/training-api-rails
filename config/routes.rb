Rails.application.routes.draw do
  post 'sign_up', to: 'users#sign_up'
  post 'sign_in', to: 'users#sign_in'
  resources :users, only: [:update, :destroy,:show] do
    member do
      get :measures
      get :followings
      get :followers
      get :scores
      get :routines
      resource :follow, only: [:create, :destroy]
    end
  end
  get 'my_follow_requests', to: 'follow_requests#my_requests'
  delete 'my_follow_requests/:id', to: 'follow_requests#my_request_cancel'
  resources :follow_requests, only: [:update, :destroy, :index] 
  resources :routines, only: [:create, :update, :destroy, :show] do
    member do
      resources :routine_exercises, only: [:create,:destroy], param: :routine_exercise_id
    end
  end
  resources :measures, only: [:create, :destroy, :update]
  resources :scores, only: [:destroy, :update]
  resources :exercises, only: [:create, :index, :update, :destroy] do
    member do
      resource :score, only: [:create]
    end
  end
  post 'routine_scores', to: 'scores#routine_score'
  root to: 'users#top'
end
