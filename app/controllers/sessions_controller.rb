class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to links_path
    else
      redirect_to new_session_path, notice: "There was a problem logging you in, please check your credentials"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You've successfully signed out."
  end
end
