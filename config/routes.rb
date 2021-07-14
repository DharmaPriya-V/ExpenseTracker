Rails.application.routes.draw do
  resources :details
  resources :users, defaults: {format: :json}
  delete "/details/:id/:expgrpid/:expid", to: "details#destroy"
  delete "/users/:id/:empid", to: "users#destroy"
  #get "/users/:id", to: "users#accept"
  post "/admin/:id", to: "admin#search"
  post "/comments/:aid/:id/:expgrpid", to: "comments#create"
  get "/comments/", to: "comments#show"
  patch "/details/:id/:user_id/:expid", to: "details#update"
 # get "/comments", to: "comments#show"
 get "/expensegroups/", to:"expensegroups#index"
 post "/expensegroups/", to:"expensegroups#create"
 get "/expensegroups/:id/:expid", to:"expensegroups#show"
 patch "/expensegroups/:id/:expgrpid", to:"expensegroups#status_modify"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
