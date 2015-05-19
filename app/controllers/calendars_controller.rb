class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  # GET /calendars
  # GET /calendars.json
  def index
    @calendars = Calendar.all
  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
  end

  # GET /calendars/new
  def new
    @calendar = Calendar.new
  end

  # GET /calendars/1/edit
  def edit
  end

  # POST /calendars
  # POST /calendars.json
  def create
<<<<<<< HEAD
    @calendar = Calendar.new(calendar_params)
    if @calendar.day_off == true
      @calendar.time_start = nil
      @calendar.time_stop = nil
    end
    @calendar.date = params[:calendar][:date].to_date
    @calendar.user_id = params[:user_id]
    respond_to do |format|
      if @calendar.save
        format.html { redirect_to @calendar, notice: 'Calendar was successfully created.' }
        format.json { render :show, status: :created, location: @calendar }
      else
        format.html { render :new }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
=======
    @one_day_calendar = Calendar.where("date = ?", calendar_params[:date])
    if !@one_day_calendar.present?
      @calendar = Calendar.new(calendar_params)
      if @calendar.day_off == true
        @calendar.time_start = nil
        @calendar.time_stop = nil
      end
      @calendar.user_id = params[:user_id]
      respond_to do |format|
        if @calendar.save
          format.html { redirect_to @calendar, notice: 'Calendar was successfully created.' }
          format.json { render :show, status: :created, location: @calendar }
        else
          format.html { render :new }
          format.json { render json: @calendar.errors, status: :unprocessable_entity }
        end
>>>>>>> 6361f966ef9f246901f2ccf6024e3221444dafc1
      end
    else
      redirect_to :back, error: "An error message for the user"
    end
  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to @calendar, notice: 'Calendar was successfully updated.' }
        format.json { render :show, status: :ok, location: @calendar }
      else
        format.html { render :edit }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar.destroy
    respond_to do |format|
      format.html { redirect_to calendars_url, notice: 'Calendar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def all
    @calendars = Calendar.all

    #@first_day = Time.now.strftime("%d-%m-%Y")
    #@second_day = (Time.now + 1.day).strftime("%d-%m-%Y")
    #@third_day = (Time.now + 2.day).strftime("%d-%m-%Y")
   
    #@first = Calendar.where("date = ?", @first_day)
    #@second = Calendar.where("date = ?", @second_day)
    #@third = Calendar.where("date = ?", @third_day)
    #@days_array = [@first, @second, @third]

    @days = []
    (0..6).each do |i|
      @days << (Time.now + i.day).strftime("%m/%d/%Y")
    end

    @seven = []
    (0..6).each do |b|
      @seven << Calendar.where("date = ?", @days[b])
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_params
      params.require(:calendar).permit(:day_off, :date, :time_start, :time_stop, :user_id, :description)
    end
end
