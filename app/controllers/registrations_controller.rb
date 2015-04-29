class RegistrationsController < DeviseTokenAuth::RegistrationsController
  #before_filter :configure_permitted_parameters
  
    def create
      super
    end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:email, :password, :password_confirmation, :registration_id, registration: [:email, :password, :password_confirmation, :registration_id])
  end

  def sign_up_params
   params.require(:registration).permit(:email, :password, :password_confirmation, :registration_id)
  end
  
end
