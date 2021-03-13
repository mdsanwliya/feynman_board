class ApplicationController < ActionController::Base
  helper_method :current_user

  before_action :current_user?

  SKIP_PATH = ["/", "/users"]

  # Check user is exist or not.
  def current_user?  
    return true if SKIP_PATH.include?(request.path)
    if current_user.blank?
      redirect_to root_path and return
    end
  end
  
  private
  
  # Get user from session 
  def current_user
    @_current_user ||= User.find_by(id: session[:current_user_id])
  end

end
