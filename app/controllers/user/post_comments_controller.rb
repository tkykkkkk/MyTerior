class User::PostCommentsController < ApplicationController
    before_action :set_post
    before_action :authenticate_user!
    
    def create
        @post_comment = PostComment.new(post_comment_params)
        @post = @post_comment.post
        if @post_comment.save
          redirect_to request.referer
        else
          flash[:alert] = "コメントに失敗しました"
        end 
    end 
    
    def destroy
        @post_comment = PostComment.find_by(id: params[:id])
        @post = @post_comment.post
        if @post_comment.destroy
          redirect_to request.referer
        else
          flash[:alert] = "コメントの削除に失敗しました"
        end
    end
    
    private
    
    def set_post
     @post = Post.find(params[:post_id])
    end
    
    def post_comment_params
        params.require(:post_comment).permit(:user_id, :post_id, :comment)
    end 
    
end
