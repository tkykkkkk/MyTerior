class  User::RelathionshipsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_guest_user
    
    def create
      user = User.find(params[:user_id])
      current_user.follow(user)
      redirect_to request.referer
    end
    
    def destroy
      user = User.find(params[:user_id])
      current_user.unfollow(user)
      redirect_to request.referer
    end 
    
    def followings
      user = User.find(params[:user_id])
      @users = user.followings
    end
    
    def followers
      user = User.find(params[:user_id])
      @users = user.followers
    end 
  
      
    private
    
    def ensure_guest_user
      if current_user.email == 'guest@example.com' 
        redirect_back fallback_location: root_path, notice: "ゲストユーザーは制限されています"
      end
    end
  
end
