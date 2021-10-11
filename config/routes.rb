Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'blogs#index'
  get "/blogs", to: "blogs#index"
  get "/blogs/new", to: "blogs#new"
  post"/blogs", to: "blogs#create"
  get "/blogs/:id", to:"blogs#show"

end
