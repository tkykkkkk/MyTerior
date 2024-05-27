# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]


  def after_sign_up_path_for(resource)
    home_path
  end
  
  

end
