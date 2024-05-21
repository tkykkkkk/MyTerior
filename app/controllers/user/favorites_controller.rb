class User::FavoritesController < ApplicationController
 before_action :authenticate_user!
   
  def create
      post = Post.find(params[:post_id])
      favorite = current_user.favorites.new(post_id: post.id)
      if favorite.save
        redirect_to request.referer
      else
        flash[:error] = "いいねの保存に失敗しました"
        redirect_to request.referer
      end
  end
  
  def destroy 
      post = Post.find(params[:post_id])
      favorite = current_user.favorites.find_by(post_id: post.id)
      favorite.destroy
      redirect_to request.referer
  end 
  
  def index
    @favorites = current_user.favorites.includes(:post)
    @posts = Post.where(id: @favorites.pluck(:post_id))
  end
end 