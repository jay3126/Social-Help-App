class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #overriding the devise method to redirect after login

  def after_sign_in_path_for(resource_or_scope)
  	"/users/dashboard"
  end

end
