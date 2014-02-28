class SignUpController < Devise::RegistrationsController
	def new
		super
	end

	def create
 		build_resource(sign_up_params)

    if resource.save
    	if params[:logo].present?
    		Logo.create(user_id: resource.id, logo: params[:logo])
    	end
      yield resource if block_given?
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
	end

	def update
		super
	end
end