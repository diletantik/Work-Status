class Api::EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  require 'gcm'

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    #respond_to do |format|
      #format.json { render :json => @events }
    #end
    render json: @events
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
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :user_id, :start_date, :stop_date)
    end
end
