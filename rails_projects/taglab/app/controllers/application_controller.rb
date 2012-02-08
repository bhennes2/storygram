class ApplicationController < ActionController::Base
  before_filter :authenticate
  
  protect_from_forgery
  
  helper_method :current_user
  
  private
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end	
  
  
  protected
  
  def authenticate
  	authenticate_or_request_with_http_basic do |username, password|
		username == "admin" && password == "admin"
  	end 
  end
  
end
