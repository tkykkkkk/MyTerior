Rails.application.routes.draw do
  
   devise_for :users, controllers: {
    registraions: "user/registrations",
    sessions: 'user/sessions'
  }

  devise_for :admins, controllers: {
    sessions: "admin/sessions"
  }
  
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
   root to: 'user/homes#top'
   get 'about' => 'user/homes#about'
   get 'home' => 'user/homes#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  namespace :user do
    resources :posts 
    get 'post_comments/create'
  end 
end
