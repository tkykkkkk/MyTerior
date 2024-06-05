class User::FavoritesController < ApplicationController
 before_action :authenticate_user!
 before_action :ensure_guest_user
   
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    if favorite.save
        # redirect_to request.referer
    else
      flash[:error] = "いいねの保存に失敗しました"
      # redirect_to request.referer
    end
  end
  
  def destroy 
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
    # redirect_to request.referer
  end 
  
  def index
    @favorites = current_user.favorites.includes(:post)
    @posts = Post.where(id: @favorites.pluck(:post_id))
  end
  
  def ensure_guest_user
    if current_user.email == 'guest@example.com' 
      redirect_back fallback_location: root_path, notice: "ゲストユーザーは制限されています"
    end
  end
  
end 