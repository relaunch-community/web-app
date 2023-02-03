Rails.application.routes.draw do
  if Rails.env.development?
    mount MaintenanceTasks::Engine => "/maintenance_tasks"
    require "sidekiq/web"
    Sidekiq::Web.app_url = "/"
    mount Sidekiq::Web => "/sidekiq"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'pages#index', as: :app_index

  # ref https://stackoverflow.com/questions/17743696/rails-routing-resources-with-only-custom-actions
  scope '/', controller: :pages do
    get :index
    get :privacy_policy
  end
end
