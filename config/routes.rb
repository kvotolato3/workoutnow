Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :workouts
      resources :workout_exercises
    end
  end
  get :about, to: 'platform#about'

  devise_for :users
  root 'exercises#index'
  resources :exercises
  resources :workouts
end
