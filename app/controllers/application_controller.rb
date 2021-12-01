class ApplicationController < ActionController::Base
    
    before_action :configure_permitted_parameters, if: :devise_controller?
	helper_method :qa? , :can_create_bug?, :can_update_bug
    
	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:user_type])
	    # devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :user_type ,:password, :password_confirmation) }
	    # devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
	    # devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation,:reset_password_token) }
	end

	def manager?
		!!user_signed_in? && current_user.user_type == "manager"
	end
	def developer?
		!!user_signed_in? && current_user.user_type == "developer"
	end

	def qa?
		!!user_signed_in? && current_user.user_type == "qa"
	end

	def can_create_bug?(project_id)
		project = Project.find(project_id)
		if qa?
		 project.user_id == current_user.id	
		 UserProject.where(project_id: project_id, user_id: current_user.id).present?
	    # project.user_id == current_user.id
			return true
		else
			return false
		end
	
	end
	
	def can_update_bug(project_id)
		!!UserProject.where(project_id: project_id, user_id: current_user.id).present? || 
		Project.find(project_id).user_id == current_user.id
	end
end
