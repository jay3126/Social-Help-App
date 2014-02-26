class UsersController < ApplicationController

	def create 
	end

	def dashboard
		@user = current_user
		if current_user.role == "Corporate"
			render "users/as_corporate"
			return
		elsif current_user.role == "NGO"
			render "users/as_ngo.html.erb"
			return
		elsif current_user.role == "Socialist"
			@issues = Issues.where(users_id: current_user.id)
			render "users/as_socialist"
			return
		end
	end
end