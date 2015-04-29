class RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_filter :configure_permitted_parameters
  
  def create
    super 
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:registration_id, :email, :password, :password_confirmation, :registration)
  end
end
