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

  def local_time(utc_time)
    time = utc_time.in_time_zone("Pacific Time (US & Canada)")
    time.strftime("%b %e %Y, %l:%M %p")
  end

  def assign_links_to_user(user)
    if session[:user_info]
      clients = Client.where("created_by = ?", session[:user_info])
      clients.each do |client|
        client.created_by = user.id
        client.save
      end
      @new_links = Link.where("created_by = ?", session[:user_info])
      @new_links.each do |new_link|
        new_link.user_id = user.id
        new_link.save
        ClientUser.create(
          client_id: new_link.client_id,
          user_id: new_link.user_id
          )
      end
    end
  end

  def add_client_user(client, user_email)
    
    @client = Client.where(name: client)
    if @client == []
      flash[:error] = "Could not find Client"
      redirect_to links_path
    end

    if @client.count > 1
      @client_users = ClientUser.where(user_id: current_user.id)
      i = 0
      while i <= @client_users.count
          @client_id = @client_users.find_by("user_id = ? AND client_id = ?", current_user.id, @client[i].id).client_id
          i += 1
      end

    else
      @client_id = @client[0].id
    end


    @user_id = User.find_by(email: user_email).id
    if @user_id == nil
      flash[:error] = "Could not find user, have they signed up yet?"
      redirect_to links_path
    end

    @client_user = ClientUser.create(client_id: @client_id, user_id: @user_id)
  end
end
