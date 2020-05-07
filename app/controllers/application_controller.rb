class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  def after_sign_in_path_for(resource_or_scope)
      if resource_or_scope == :user
        user_path(resource)
      elsif resource_or_scope == :admin_user
        admin_root
      else
      end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
      '/'
    elsif resource_or_scope == :admin_user
      new_admin_user_session_path
    else
    end
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
