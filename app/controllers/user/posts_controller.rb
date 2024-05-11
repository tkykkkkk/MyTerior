class User::PostsController < ApplicationController
   before_action :authenticate_user!
  
  def new
    @post = Post.new
    @post.photos.build
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    if @post.photos.present?
      @post.save!
      redirect_to user_posts_path
      flash[:notice] = "投稿が保存されました"
    else
      render :new
      flash[:alert] = "投稿に失敗しました"
    end
  end 

  def index
    @posts = Post.limit(10).order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
  end
  
 private
    def post_params
      params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
    end
  
end
