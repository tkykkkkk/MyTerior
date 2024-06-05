class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @posts = Post.all.order('created_at DESC')
  end 
  
  def show 
    @post = Post.find_by(id: params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments
  end 
  
  def edit 
    @post = Post.find(params[:id])
  end 
  
  def update 
    @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to admin_post_path(@post.id)
      else 
        render :edit 
      end
  end 
  
  def destroy
    @post = Post.find_by(id: params[:id])
      if @post.destroy
        flash[:notice] = "投稿が削除されました"
        redirect_to admin_posts_path
      else
         flash[:alert] = "投稿の削除に失敗しました"
        render :show
      end
  end 
  
  private
    def post_params
      params.require(:post).permit(:caption, photos_attributes: [:image])
    end
  
end
