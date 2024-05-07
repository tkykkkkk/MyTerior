Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, controllers: {
    registraions: "user/registrations",
    sessions: 'user/sessions'
  }
  
   root to: 'user/homes#top'
   get 'about' => 'public/homes#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :user do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
    get 'post_comments/create'
    get 'homes/top'
  end 
end
