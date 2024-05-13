Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  devise_for :admins, skip: [:registrations, :passwords],  controllers: {
    sessions: "admin/sessions"
  }
  
  root to: 'user/homes#top'
    get 'about' => 'user/homes#about'
    get 'home' => 'user/homes#home'
         
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
  scope module: :user do
    
   resources :posts, only: %i(new create index show destroy) do
    resources :photos, only: %i(create)
    resources :post_comments, only: %i(create destroy)
  end
    get 'my_page/:id', to: 'users#show', as: :user
#   get 'my_page/:id', to: 'users#show'
#   get 'edit/my_page/:id', to: 'users#edit'
#   patch 'update/my_page/:id', to: 'users#update'
   
  end 
end
