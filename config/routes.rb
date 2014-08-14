Rails.application.routes.draw do

  root 'felicas#index'

  resources :events, only: %i(index edit update)
  resources :groups
  resources :locations
  resources :posts
  resources :users

  resources :felicas, only: %i(index create show destroy) do
    resource :user, only: %i(new create edit update)
  end

  namespace :api do
    scope :arduino do
      resource :felica, only: [] do
        get :create
      end

      resource :event, only: [] do
        get :create
      end
    end
  end

end
