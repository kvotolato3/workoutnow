Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :workouts
    end
  end

  devise_for :users
  root 'exercises#index'
  resources :exercises
  resources :workouts
end
