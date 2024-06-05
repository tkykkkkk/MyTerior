# frozen_string_literal: true

class Admin::RegistrationsController < Devise::RegistrationsController
 before_action :authenticate_admin!
end
