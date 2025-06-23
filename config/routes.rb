Rails.application.routes.draw do
  resources :appointments
  resources :patients
  # Devise routes for user authentication
  devise_for :users

  # Dashboard routes
  get "dashboards/doctor"
  get "dashboards/receptionist"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Set default root route
  root to: "dashboards#receptionist"  # or any landing page you prefer
end
