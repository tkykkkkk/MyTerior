class User::HomesController < ApplicationController
   before_action :authenticate_user!
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
end
