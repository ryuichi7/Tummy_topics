class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 protect_from_forgery with: :exception
# if Rails.env.production?
#   rescue_from ActiveRecord::RecordNotFound, with: :not_found 
# 	rescue_from Exception, with: :not_found
# 	rescue_from ActionController::RoutingError, with: :not_found
#   rescue_from CanCan::AccessDenied do |exception|
# 		redirect_to root_path, :alert => exception.message
# 	end
# end
before_filter :configure_permitted_parameters, if: :devise_controller?
	
	def raise_not_found
		raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
	end

	

	def after_sign_in_path_for(resource)
  	request.env['omniauth.origin'] || root_path
	end

	def not_found
		respond_to do |format|
			format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
			format.xml { head :not_found }
			format.any { head :not_found }
		end
	end	

	def process(action, *args)
    super
  	rescue AbstractController::ActionNotFound
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found  }
      format.all { render nothing: true, status: :not_found }
    end
  end

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :avatar) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :avatar) }
  end

end

