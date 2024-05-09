class User::PostsController < ApplicationController
  brfore_action :authenticate_user!
  
  def new
    @post = Post.new
    @post.photos.build
  end
  
  def create
    @post = Post.new(post_params)
    if @post.photos.present?
     @post.save
     flash[:notice] = "投稿に成功しました"
     redirect_to root_path
    else
     @posts = Post.all
     flash[:alert] = "投稿に失敗しました"
     redirect_to root_path
    # render :index
    end 
     
  end 

  def index
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
  end
  
  private
  
  def post_params
    params.require(:post).permit(:caption, photos_attributes: [:image]) 
    # .merge(user_id: current_user.id)
  end 
  
end
