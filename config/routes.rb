Rails.application.routes.draw do
  resources :details
  resources :users, defaults: {format: :json}
  delete "/details/:id/:expgrpid/:expid", to: "details#destroy"
  delete "/users/:id/:empid", to: "users#destroy"
  patch "/users/:id/:eid", to: "users#terminate"
  #get "/users/:id", to: "users#accept"
  post "/admin/:id", to: "admin#search"
  post "/comments/:aid/:id/:expgrpid", to: "comments#create"
  delete "/comments/:id/:eid/:expgrpid/:detail_id/:cid", to: "comments#destroy_admin"
  delete "/comments/:id/:expgrpid/:detail_id/:cid", to: "comments#destroy_employee"
  get "/comments/", to: "comments#show"
  patch "/details/:id/:user_id/:expgrpid/:expid", to: "details#update"
  patch "/details/:id/:expgrpid/:expid", to: "details#update_detail"
  get "/comments", to: "comments#show"
 get "/expensegroups/", to:"expensegroups#index"
 post "/expensegroups/", to:"expensegroups#create"
 get "/expensegroups/:id/:expid", to:"expensegroups#show"
 patch "/expensegroups/:id/:expgrpid", to:"expensegroups#status_modify"
 delete "/expensegroups/:id/:expgrpid", to:"expensegroups#destroy"
 post "/comments/:id/:expgrpid", to: "comments#reply"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
