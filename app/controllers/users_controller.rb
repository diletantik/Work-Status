class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

   def index
    @users = User.all
  end

   def create
      @resource            = User.new(sign_up_params)
      @resource.provider   = "email"

      # honor devise configuration for case_insensitive_keys


            @client_id = SecureRandom.urlsafe_base64(nil, false)
            @token     = SecureRandom.urlsafe_base64(nil, false)

            @resource.tokens[@client_id] = {
              token: BCrypt::Password.create(@token),
              expiry: (Time.now + DeviseTokenAuth.token_lifespan).to_i
            }
        
          if @resource.save!
            session[:user_id] = @resource.id
            #render json: {:new => 'succesfully registered'}
            #render :json => { :message => I18n.t('successfull.deleted'), :status => 200}, :status => 200
            #respond_to do |format|
            #render :json => {:success => 'Yep', 
                                              #:status => 200}, :status => 200
             # format.json { render json: {:new => 'succesfully registered'}}

             #end
             redirect_to users_path
          else
            #render :json => {:error => @resource.errors.full_messages, 
                                              #:status => 422}, :status => 422
            
            #render json: @resource.errors.full_messages.to_json
            #respond_to do |format|
            #  format.json { render json: @resource.errors.full_messages }

            # end

          end
    end


  protected

  def sign_up_params
   params.require(:user).permit(:email, :password, :password_confirmation, :registration_id, :first_name, :last_name)
  end

end