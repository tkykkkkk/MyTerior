# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  
  
  def after_sign_up_path_for(resource)
    home_path
  end 

  # GET /resource/sign_up
  # def new
  #   super
  # en

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  #def update
    #update_resource(resource, user_params)
    #build_resource(user_params)
    #super
  #end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
   
#   def user_params
#       # :name パラメーターを許可する
#       params.require(:user).permit(:name, :profile_image, :introduction)
#   end

  # If you have extra params to permit, append them to the sanitizer.
 
  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
