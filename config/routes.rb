Rails.application.routes.draw do

  root 'users#index'

  resources :events, only: %i(index edit update)
  resources :groups
  resources :locations
  resources :users

  resources :posts do
    collection do
      get :write
      post :deliver
    end

  end
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

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
