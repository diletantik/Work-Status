class Api::CalendarController < ApplicationController
   def index
      
      @days = []
      (0..6).each do |i|
        @days << (Time.now + i.day).strftime("%m/%d/%Y")
      end

      @seven = []
      (0..6).each do |b|
        @seven << Calendar.where("date = ?", @days[b])
      end

      render json: @seven
    end



end