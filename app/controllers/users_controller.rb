class UsersController < ApplicationController
  
  def new
    @resource = User.new
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
          
     
          respond_to do |format|
            if @resource.save
              session[:user_id] = @resource.id
              format.html { redirect_to users_path, notice: 'User was successfully created.' }
              format.json { render :index, status: :created}
              #render json: {:new => 'succesfully registered'}
              #render :json => { :message => I18n.t('successfull.deleted'), :status => 200}, :status => 200
              #respond_to do |format|
              #render :json => {:success => 'Yep', 
                                                #:status => 200}, :status => 200
               # format.json { render json: {:new => 'succesfully registered'}}

               #end
               #redirect_to users_path
            else
              format.html { render :new }
              format.json { render json: @resource.errors, status: :unprocessable_entity }
              #render :json => {:error => @resource.errors.full_messages, 
                                                #:status => 422}, :status => 422
              
              #render json: @resource.errors.full_messages.to_json
              #respond_to do |format|
              #  format.json { render json: @resource.errors.full_messages }

              # end
            end
          end
    end


  protected

  def set_user
    @user = User.find(params[:id])
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :registration_id, :first_name, :last_name, :sign_in_count)
  end

end