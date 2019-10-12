Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    get 'exhibitions/index', to: 'exhibitions#index'

    devise_for :users, controllers: { sessions: :sessions },
               path_names: { sign_in: :login }
    delete 'users/logout', action: :logout, controller: 'application'
  end

end
