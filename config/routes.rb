Rails.application.routes.draw do
  resources :jobs
  get '/jobs/title/:title', to: 'jobs#get_by_title'
  post '/jobs/applied', to: 'applies#create'

  post "/login", to: "sessions#login"
  post "/signup", to: "sessions#signup"
end
