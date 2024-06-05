class User::MessagesController < ApplicationController
  before_action :authenticate_user!, :only => [:create]
  before_action :ensure_guest_user

  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:message,:user_id, :content, :room_id).merge(:user_id => current_user.id))
      redirect_to "/rooms/#{@message.room_id}"
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
  def ensure_guest_user
    if current_user.email == 'guest@example.com' 
      redirect_back fallback_location: root_path, notice: "ゲストユーザーは制限されています"
    end
  end  
  
end
