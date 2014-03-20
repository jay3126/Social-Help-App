class SessionsController < Devise::SessionsController
def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

	def auth_options
	    { scope: resource_name, recall: 'users#home' }
  end	
end