class UsersController < ApplicationController

	def edit
		@user = current_user
	end

	def profile
	end

	def update_profile
		@user = current_user
		if @user.update_without_password(user_profile_params)
			redirect_to profile_path
		else
			render action: :edit
		end
	end

	private
	def user_profile_params
		params.require(:user).permit(:name, :address, :city, :pin_code, :state, :country, :mobile_number, :phone_number, :fax_number, :company_group, :tan_number, :no_of_employees, :age, :gender, :adhaar_number, :voter_id, :nationality, :pan_number, :service_type, :owner, :year_established)
	end

end