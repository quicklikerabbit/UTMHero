module ApplicationHelper

  def require_logged_in_user
    unless current_user
      flash[:error] = "You must be logged in to see your links"
      redirect_to root_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
