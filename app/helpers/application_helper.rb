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
    @client_id = Client.where(name: client)
    if @client_id == []
      flash[:error] = "Could not find Client"
      redirect_to links_path
    end
    if @client_id.count > 1
      # refine client list to include only those where current user is listed
      # as a client_user for that client
      # "name LIKE ? AND created_by = ?", link_params[:client_id], @user_info
    else
      @client_id = @client_id[0].id
    end


    @user_id = User.find_by(email: user_email).id
    if @user_id == nil
      flash[:error] = "Could not find user, have they signed up yet?"
      redirect_to links_path
    end

    @client_user = ClientUser.create(client_id: @client_id, user_id: @user_id)
  end
end
