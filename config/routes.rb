Rails.application.routes.draw do
  
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions',
    passwords: 'user/passwords'
  }

  devise_for :admins, skip: [:registrations, :passwords],  controllers: {
    sessions: "admin/sessions"
  }
  
  root to: 'user/homes#top'
    get 'home' => 'user/homes#home'
    
  namespace :admin do
     resources :users, only: %i(index show edit update)
     resources :posts, only: %i(index show edit update destroy) do
       resources :post_comments, only: %i(destroy)
     end
     resources :genres, only: [:index, :create, :edit, :update]
   end 
         
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
 
  scope module: :user do
    
   resources :posts, only: %i(new create index show edit update destroy) do
    resources :photos, only: %i(create)
    resources :post_comments, only: %i(create destroy)
    resource :favorite, only: %i(create destroy)
  end
    resources :favorites, only: [:index]
  # resources :users, only: %i(show edit update)
   resources :users, only: %i(show edit update) do 
     resource :relathionships, only: %i(create destroy)
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end 
#   get 'my_page/:id', to: 'users#show'
#   get 'edit/my_page/:id', to: 'users#edit'
#   patch 'update/my_page/:id', to: 'users#update'
   
  end 
  
end
