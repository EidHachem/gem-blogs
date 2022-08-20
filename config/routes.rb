Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  get '/user/:id', to: 'users#show'
  get '/post/new', to: 'posts#new'
  post '/post/new', to: 'posts#create'
  post '/addcomment/:id', to: "comments#addcomment"
  get '/user/:id/post/', to: 'posts#posts'
  get '/user/:id/post/:id', to: 'posts#post'
  get 'addlike/:id', to: "likes#addlike"
end
