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
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
          gcm = GCM.new("AIzaSyDvtdYEIqM-aUioqWS0YZOTIQqrGshtuPM")
        registration_ids= ["APA91bHn3hqi03_vzntd6hKARcFQj9k4tE9Xf7wLKWQIFqh8j8K9D8iRLpelrCRb0vtplDGRbkpl2_Wt5U7CNM8ZH-JRhOtEwkrr1kBJydqkDjkk9DFbK5CgmMvv9UPHEo5Y-rVc-gWHHGR5JciQaM-oHPSSsV7zCA"] # an array of one or more client registration IDs
        options = {data: {message: "HALLO MUTHERFUCKERS"}}
        response = gcm.send(registration_ids, options)
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

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
      if $current_user.status_id != params[:status_id]
        $current_user.status_id = params[:status_id]
        $current_user.save
      end
      render json: {:status_id => $current_user.status_id}
    else
      render json: {:message => "U dont have permission to look this page"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :phone, :status_id, :skype, :role_id, :department_id, :avatar)
    end
end