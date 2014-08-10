Rails.application.routes.draw do
  root 'felicas#index'

  resources :groups
  resources :locations
  resources :users
  resources :events, only: %i(index edit update)

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
