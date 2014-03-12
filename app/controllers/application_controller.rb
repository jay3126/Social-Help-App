class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #overriding the devise method to redirect after login
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!, except: [:donate]

  def after_sign_in_path_for(resource_or_scope)
  	dashboard_path
  end

  protected

 	def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) { |u| 
      u.permit(:email, :password, :password_confirmation, :role, :name, :address, :city, :pin_code, :state, :country, :mobile_number, :phone_number, :fax_number, :service_type, :owner, :year_established, :age, :gender, :adhaar_number, :voter_id, :nationality, :pan_number, :company_group, :tan_number, :no_of_employees)
   }
   devise_parameter_sanitizer.for(:account_update) { |u| 
      u.permit(:email, :password, :password_confirmation, :role, :name, :address, :city, :pin_code, :state, :country, :mobile_number, :phone_number, :fax_number, :service_type, :owner, :year_established, :age, :gender, :adhaar_number, :voter_id, :nationality, :pan_number, :company_group, :tan_number, :no_of_employees)
   }
	end

end
