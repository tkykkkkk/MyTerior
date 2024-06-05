class User::HomesController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about, :terms, :redirect_new]
  def top
  end
  
  def home
    @posts = Post.order('created_at DESC').limit(5)
    @users = User
      .select('users.*, COUNT(favorites.id) AS favorites_count')
      .joins(posts: :favorites)
      .group('users.id')
      .order('favorites_count DESC')
      .limit(10)  # 表示したいユーザー数を指定
  end 
  
  def about
  end 
  
  def terms
  end 
  
  def redirect_new
    redirect_to new_user_registration_path
  end 
  
end
