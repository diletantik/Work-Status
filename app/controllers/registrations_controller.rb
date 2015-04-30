class RegistrationsController < DeviseTokenAuth::RegistrationsController
  #before_filter :configure_permitted_parameters
  
    def create
      @resource            = resource_class.new(sign_up_params)
      @resource.provider   = "email"

      # honor devise configuration for case_insensitive_keys
      if resource_class.case_insensitive_keys.include?(:email)
        @resource.email = sign_up_params[:email].downcase
      else
        @resource.email = sign_up_params[:email]
      end

            @client_id = SecureRandom.urlsafe_base64(nil, false)
            @token     = SecureRandom.urlsafe_base64(nil, false)

            @resource.tokens[@client_id] = {
              token: BCrypt::Password.create(@token),
              expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
            }
        
          if @resource.save!
            #render json: {:new => 'succesfully registered'}
            #render :json => { :message => I18n.t('successfull.deleted'), :status => 200}, :status => 200
            #respond_to do |format|
            render :json => {:success => 'Yep', 
                                              :token => @resource.tokens,
                                              :status => 200}, :status => 200
             # format.json { render json: {:new => 'succesfully registered'}}

             #end
          else
            render :json => {:error => @resource.errors.full_messages, 
                                              :status => 422}, :status => 422
            
            #render json: @resource.errors.full_messages.to_json
            #respond_to do |format|
            #  format.json { render json: @resource.errors.full_messages }

            # end
          end
    end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:email, :password, :password_confirmation, :registration_id, registration: [:email, :password, :password_confirmation, :registration_id])
  end

  def sign_up_params
   params.require(:registration).permit(:email, :password, :password_confirmation, :registration_id)
  end
  
end