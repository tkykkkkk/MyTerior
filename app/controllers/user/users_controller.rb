class User::UsersController < ApplicationController
  
  def show
    @user = User.find_by(id: params[:id])
    # @posts = @user.posts
  end 
  
   
  #   private 
  
  # def user_params
  # params.require(:user).permit(:name, :profile_image, :introduction)
  # end 

  # def ensure_correct_user
  #   @user = User.find(params[:id])
  #   unless @user == current_user
  #     redirect_to user_path(current_user)
  #   end
  # end 
end
