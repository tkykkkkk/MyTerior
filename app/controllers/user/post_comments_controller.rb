class User::PostCommentsController < ApplicationController
    before_action :set_post
    before_action :authenticate_user!
    before_action :ensure_guest_user
    
    def create
        @post_comment = PostComment.new(post_comment_params)
        @post = @post_comment.post
        if @post_comment.save
          redirect_to request.referer
        else
          flash[:notice] = "コメントに失敗しました"
          redirect_to request.referer
        end 
    end 
    
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
    
    def set_post
     @post = Post.find(params[:post_id])
    end
    
    def post_comment_params
        params.require(:post_comment).permit(:user_id, :post_id, :comment)
    end 
    
    def ensure_guest_user
      if current_user.email == 'guest@example.com' 
        redirect_back fallback_location: root_path, notice: "ゲストユーザーは制限されています"
      end
    end
    
end
