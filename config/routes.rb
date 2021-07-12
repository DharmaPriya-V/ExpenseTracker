Rails.application.routes.draw do
  resources :details
  resources :users, defaults: {format: :json}
  delete "/details/:id/:eid", to: "details#destroy"
  #get "/users/:id", to: "users#accept"
  post "/admin/:id", to: "admin#search"
  post "/comments/:id", to: "comments#create"
  get "/comments/:id", to: "comments#show"
 # get "/comments", to: "comments#show"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
