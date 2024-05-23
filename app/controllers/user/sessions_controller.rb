# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
   #before_action :configure_sign_in_params, only: [:create]
   before_action :user_state, only: [:create]
   before_action :reject_user, only: [:create]
   
   
   def after_sign_in_path_for(resource)
    home_path
  end 
  
  def after_sign_out_path_for(resource)
    root_path
  end 
   
   private
   
   def user_state
    #アクティブであるかどうか判断する
    user = User.find_by(email: params[:user][:email])
    # 処理１（アカウントが取得できなかった場合はメソッドを終了する
    return if user.nil?
    # 処理２（取得したアカウントのパスワードと入力されたパスワードが一致したない場合、このメソッドを終了する
    return unless user.valid_password?(params[:user][:password])
   end 
   
   def reject_user
       @user = User.find_by(email: params[:user][:email])
       if @user
         if @user.valid_password?(params[:user][:email]) && (@user.is_active == false)
            flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
            redirect_to new_user_registration_path
         else
            flash[:notice] = "項目を入力してください"
         end 
       else
           flash[:notice] = "該当するユーザーが見つかりません"
       end 
   end 
 
    
    
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
