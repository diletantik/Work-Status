class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def authenticate
    if (!current_user)&&(params[:registration_id].present?)
      $current_user = User.where('registration_id = ?', params[:registration_id]).first
    end
      
  end
  
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  
  
end
