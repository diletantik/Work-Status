class Api::UsersController < ApplicationController
  before_filter :authenticate
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  require 'gcm'

  # GET /events
  # GET /events.json
  def index
    if $current_user
      @users = User.all
      #respond_to do |format|
        #format.json { render :json => @events }
      #end
      render json: @users
    else
      render json: {:message => "U dont have permission to look this page"}
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def info
    @user = $current_user
    render json: @user
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
      if @user.update(user_params)
       if @user.save!
            #render json: {:new => 'succesfully registered'}
            #render :json => { :message => I18n.t('successfull.deleted'), :status => 200}, :status => 200
            #respond_to do |format|
            render :json => {:success => 'Yep', 
                                              :status => 200}, :status => 200
             # format.json { render json: {:new => 'succesfully registered'}}

             #end
          else
            render :json => {:error => @user.errors.full_messages, 
                                              :status => 422}, :status => 422
            
            #render json: @resource.errors.full_messages.to_json
            #respond_to do |format|
            #  format.json { render json: @resource.errors.full_messages }

            # end
          end
        end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_status
    if $current_user
      @current_user = $current_user
      puts @current_user
      @current_user.update!(status_id: params[:status_id], password: params[:password])
      #@current_user.save
      puts @current_user
      # if @current_user.status_id != params[:status_id]
        #@current_user.status_id = params[:status_id]
        puts @current_user.status_id
        #@current_user.save
        #render json: @current_user.status_id
      render :json => {:status_id => @current_user.status_id, 
                                              :status => 200}, :status => 200
      else
        render :json => {:yahoo => "yeyoo", :status => 200}, :status => 200
      end

      
      #else
      #  render json: {:message => "U dont have permission to look this page"}
      #end
  end
  
  def change_photo
    @user = $current_user
    if params[:image].present?
      image = Paperclip.io_adapters.for(params[:image]) 
      image.original_filename = params[:image_name]
      @user.update!(avatar: image, password: params[:password])
      render :json => {:user_avatar => @user.avatar.url, :status => 200}, :status => 200
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :phone, :status_id, :skype, :role_id, :department_id, :avatar, :registration_id)
    end
end