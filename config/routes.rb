Rails.application.routes.draw do

  post 'circles/:circle_id/join_circle' => "circles#join_circle"
  post 'circles/:circle_id/change_circle' => "circles#change_circle"
  get 'circles/:circle_id/:id/join_index' => "circles#join_index"
  get 'circles/:circle_id/index' =>  "circles#index"
  get 'circles/new' => "circles#new"
  get 'circles/:id' => "circles#show"
  get 'circles/:id/edit' => "circles#edit"
  post 'circles/create' => "circles#create"
  post "circles/:id/remove_circle" => "circles#remove_circle"
  
  

  post "books/:circle_id/:id/return_book" => "books#return_book"
  post "books/:circle_id/:id/remove_book" => "books#remove_book"
  post "books/:circle_id/:id/lending" => "books#lending"
  get "books/:circle_id/:id/lend" => "books#lend"
  post "books/:circle_id/:id/update" => "books#update"
  get "books/:circle_id/:id/edit" => "books#edit"
  post "books/:circle_id/create" => "books#create"
  get 'books/:circle_id/books_signup' => "books#new"
  get 'books/:circle_id/index' => "books#index"
  get 'books/:circle_id/:id' => "books#show"


  post"likes/:circle_id/:post_id/create" => "likes#create"
  post "likes/:circle_id/:post_id/destroy" => "likes#destroy"

  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"

  post "users/:circle_id/:id/update" => "users#update"
  post "users/:id/remove_user" => "users#remove_user"
  get "users/:circle_id/:id/edit" => "users#edit"
  post "users/create" => "users#create"
  get "signup" => "users#new"
  get "users/:circle_id/index" => "users#index"
  get "users/index_manager" => "users#index_manager"
  get "users/:circle_id/:id" => "users#show"
  get "users/:circle_id/:id/likes" => "users#likes"

  get "posts/:circle_id/index" => "posts#index"
  get "posts/:circle_id/new" => "posts#new"
  get "posts/:circle_id/:id" => "posts#show"
  post "posts/:circle_id/create" => "posts#create"
  get "posts/:circle_id/:id/edit" => "posts#edit"
  post "posts/:circle_id/:id/update" => "posts#update"
  post "posts/:circle_id/:id/destroy" => "posts#destroy"

  get "/" => "home#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
