class SessionsController < Devise::SessionsController
	def auth_options
	    { scope: resource_name, recall: 'users#home' }
  end	
end