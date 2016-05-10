class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if session[:start_time]
        @client_users = ClientUser.all
        @new_links = Link.where("created_at > ?", session[:start_time])
        @new_links.each do |new_link|
          new_link.user_id = user.id
          new_link.save
          if @client_users.find_by(client_id: new_link.client_id) == nil
            ClientUser.create(
              client_id: new_link.client_id,
              user_id: new_link.user_id
              )
          end
        end
      end
      redirect_to links_path, notice: "Hey there, #{user.first_name}!"
    else
      redirect_to new_session_path, notice: "There was a problem logging you in, please check your credentials"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:start_time] = nil
    redirect_to root_path, notice: "You've successfully signed out."
  end
end
