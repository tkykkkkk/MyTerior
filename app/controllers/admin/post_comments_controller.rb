class Admin::PostCommentsController < ApplicationController
    before_action :authenticate_admin!
    
   def destroy
        @post_comment = PostComment.find_by(id: params[:id])
        @post = @post_comment.post
        if @post_comment.destroy
          redirect_to request.referer
        else
          flash[:notice] = "コメントの削除に失敗しました"
        end
    end 
end
