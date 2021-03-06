class SessionsController < ApplicationController
  include ApplicationHelper
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      assign_links_to_user(@user)
      redirect_to links_path, notice: "Hey there, #{@user.first_name}!"
    elsif @user == nil
      redirect_to new_session_path, notice: "User not found, have you signed up yet?"
    else
      redirect_to new_session_path, notice: "There was a problem logging you in, please check your credentials"
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "You've successfully signed out."
  end
end
