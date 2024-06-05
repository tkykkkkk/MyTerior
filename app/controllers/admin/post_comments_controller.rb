class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :is_matching_login_user, only: [:destroy]
  
    
  def destroy
    @post_comment = PostComment.find_by(id: params[:id])
    @post = @post_comment.post
      if @post_comment.destroy
        redirect_to request.referer
      else
        flash[:notice] = "コメントの削除に失敗しました"
      end
  end 
  
  private
  
  def is_matching_login_user
    post_comment = PostComment.find(params[:id])
    unless post_comment.user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
