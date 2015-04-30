class Api::SessionsController < ApplicationController
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

  def sign_in
    @password = params[:password].encrypted_password
    @user = User.where('email = ? AND password = ?', params[:eamil], @password).first
    if @user
      render json: {:registration_id => @user.registration_id}
    else
      render json: {:message => "Wrong email or password"}
    end
  end
end