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
    get 'about' => 'user/homes#about'
    get 'terms' => "user/homes#terms"
    get 'users' => "user/homes#redirect_new"
    
  namespace :admin do
     resources :users, only: %i(index show edit update)
     resources :posts, only: %i(index show edit update destroy) do
       resources :post_comments, only: %i(destroy)
     end
     resources :genres, only: [:index, :create, :edit, :update, :destroy]
   end 
         
  devise_scope :user do
    post "user/guest_sign_in", to: "user/sessions#guest_sign_in"
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
      get "followings" => "relathionships#followings", as: "followings"
      get "followers" => "relathionships#followers", as: "followers"
    #退会確認画面
      get '/check' => 'users#check'
      patch '/withdraw' => 'users#withdraw'
      
    end 
    
    resources :messages, only: [:create]
    resources :rooms, only: [:create,:show, :index]
    get "search" => "searches#search"
#   get 'my_page/:id', to: 'users#show'
#   get 'edit/my_page/:id', to: 'users#edit'
#   patch 'update/my_page/:id', to: 'users#update'
   
  end 
  
end
