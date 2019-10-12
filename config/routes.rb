# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      devise_for :users, skip: [:sessions]
    end
  end
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'exhibitions/index', to: 'exhibitions#index'
      # we don't need other dvise enpoints for now
      post 'users/login', action: :create, controller: 'sessions'
      delete 'users/logout', action: :destroy, controller: 'sessions'
    end
  end
end
