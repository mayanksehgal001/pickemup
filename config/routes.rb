require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)
  devise_for :users
 
  mount Sidekiq::Web, at: '/sidekiq'
  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == ["mayank", "pickemup@rocks"]
  end

  namespace :api do

    devise_for :users, defaults: { format: :json }

    post 'auth/token', to: 'authenticate#generate_token'

    namespace :admin, format: :json do
      resources :auth, only: [] do
        get :refresh, on: :collection
      end

      resources :questions

      resources :answers, only: [:index, :show, :create]

      resource :statistics, only: [:show]
    end
  end


  resources :dashboards, only: [:index, :show]

  root to: 'dashboards#index'

  get '/*path', to: 'dashboards#index'

end
