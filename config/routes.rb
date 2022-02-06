Rails.application.routes.draw do
  resources :jobs
  post "/login", to: "sessions#login"
  post "/signup", to: "sessions#signup"
end
