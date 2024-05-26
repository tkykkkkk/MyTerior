class User::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, except: [:show, :index]

  def new
    @post = Post.new
    @post.photos.build
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @genre = Genre.find_by(id: params[:post][:genre_id])

    if @post.save
      flash[:notice] = "投稿が保存されました"
      redirect_to posts_path
    else
      @post.photos.build
      flash[:alert] = "投稿に失敗しました"
      render :new
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
      redirect_to post_path(@post.id), notice: "投稿を編集しました"
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
    params.require(:post).permit(:genre_id, :caption, photos_attributes: [:id, :image, :_destroy])
  end
  
  def ensure_guest_user
    if current_user.email == 'guest@example.com' 
      redirect_back fallback_location: root_path, notice: "ゲストユーザーは制限されています"
    end
  end
  
end
