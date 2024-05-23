class User::UsersController < ApplicationController
  # before_action :ensure_correct_user, only: [:edit, :update]
  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
    # DM機能
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
      if @user.id == current_user.id
      else
       @currentUserEntry.each do |cu|
         @userEntry.each do |u|
           if cu.room_id == u.room_id then 
             @isRoom = true 
             @roomID = cu.room_id
           end 
         end 
       end 
       
      if @isRoom
      else 
        @room = Room.new
        @entry = Entry.new
      end 
      end 
  end 
  
  def edit
   @user = User.find_by(id: params[:id])
  end 
  
  def update
    @user = User.find_by(id: params[:id])
    
    if @user.update!(user_params)
      flash[:notice]="プロフィールの変更に成功しました"
      redirect_to user_path(@user)
    else
      flash[:notice]="プロフィールの変更に失敗しました"
      render :edit
    end 
  end 
  
   
   private 
  
  # def user_params
  # params.require(:user).permit(:name, :profile_image, :introduction)
  # end 

  # def ensure_correct_user
  #   @user = User.find(params[:id])
  #   unless @user == current_user
  #     redirect_to user_path(current_user)
  #   end
  # end 
  # def set_post
  #   @post = Post.find(params[:post_id])
  # end
  def user_params
    params.require(:user).permit(:name, :email, :introduction)
  end 
  
end
