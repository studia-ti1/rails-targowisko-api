Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    get 'exhibitions/index', to: 'exhibitions#index'
    # we don't need other dvise enpoints for now
    devise_for :users, :skip => [:sessions]
    post 'users/login', action: :create, controller: 'sessions'
    delete 'users/logout', action: :destroy, controller: 'sessions'
  end
end
