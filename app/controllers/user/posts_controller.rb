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
      @post.save
      redirect_to posts_path
      flash[:notice] = "投稿が保存されました"
    else
      render :new
      flash[:alert] = "投稿に失敗しました"
    end
  end 

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
    unless @post.user.id == current_user.id
      redirect_to post_path(@post.id)
    end
  end 
  
  def update
      @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path (@post.id), notice: "投稿を編集しました"
    else
      render :edit
    end
  end 
  

  def destroy
    @post = Post.find_by(id: params[:id])
      if @post.user == current_user
        flash[:notice] = "投稿が削除されました" if @post.destroy
      else
        flash[:alert] = "投稿の削除に失敗しました"
      end
      redirect_to user_path(current_user.id)
  end
  
 private
    def post_params
      params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
    end
  
end
