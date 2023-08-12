Rails.application.routes.draw do
  namespace :founder do
    resources :firm_roles
    resources :firms do
      resources :firm_roles
    end
  end

  namespace :investor do
    resources :firm_roles
    resources :firms do
      resources :firm_roles
    end
  end

  resources :physical_locations
  namespace :user_profile, path: :profile do
    resources :personals, path: :personal
    resources :professionals, path: :professional, except: [:new, :create]
  end

  devise_for :users, controllers: {
    confirmations: "users/confirmations",
    # TODO: omniauth_callbacks: "users/omniauth_callbacks",
    passwords: "users/passwords",
    registrations: "users/registrations",
    sessions: "users/sessions",
    unlocks: "users/unlocks"
  }

  if Rails.env.development?
    mount MaintenanceTasks::Engine => "/maintenance_tasks"
    require "sidekiq/web"
    Sidekiq::Web.app_url = "/"
    mount Sidekiq::Web => "/sidekiq"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "pages#index", as: :app_index

  scope "dashboard", controller: :dashboard do
    get "/", to: "dashboard#show", as: "dashboard"
    get "coming-soon", to: "dashboard#coming_soon"
  end

  # ref https://stackoverflow.com/questions/17743696/rails-routing-resources-with-only-custom-actions
  scope "/", controller: :pages do
    get :index
    get "about", to: "pages#about"
    get "privacy-policy", to: "pages#privacy_policy"
    get "code-of-conduct", to: "pages#code_of_conduct"
    get "anti-harassment", to: "pages#anti_harassment"
  end
end
