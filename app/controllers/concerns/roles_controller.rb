class RolesController < InheritedResources::Base
before_filter :authenticate_user!
load_and_authorize_resource

private
	def role_params
		params.require(:role).permit(:name, :description)
	end
end