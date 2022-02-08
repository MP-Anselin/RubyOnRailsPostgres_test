Rails.application.routes.draw do
  resources :jobs
  get '/jobs/title/:title', to: 'jobs#get_by_title'
  get '/jobs/languages/:language', to: 'jobs#get_by_language'
  post '/jobs/applied', to: 'applies#create'

  post "/login", to: "sessions#login"
  post "/signup", to: "sessions#signup"
  post "/logout", to: "sessions#logout"
end
