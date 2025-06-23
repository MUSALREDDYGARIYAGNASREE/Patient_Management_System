class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # ✅ Allow Devise to accept custom params like :role
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
    devise_parameter_sanitizer.permit(:account_update, keys: [:role])
  end

  # ✅ Redirect users to their dashboard based on role
  def after_sign_in_path_for(resource)
    if resource.role == "doctor"
      dashboards_doctor_path
    elsif resource.role == "receptionist"
      dashboards_receptionist_path
    else
      root_path
    end
  end

  # ✅ Redirect user to login page after sign out
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
