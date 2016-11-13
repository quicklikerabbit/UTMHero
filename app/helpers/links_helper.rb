module LinksHelper
  def links_table_content
    if current_user
      @client_links = ClientUser.where(user_id: current_user.id).pluck(:client_id)
      @links = Link.where(client_id: @client_links).order(created_at: :desc)

      @link = Link.new
      @clients = Client.where(id: @client_links)
      @users = User.all
      @last_link = @links.first

      if @clients.count > 0
        @client_name = @clients.find(@last_link.client_id).name
      end

      @created_times = []
      @client_names = []
      @user_names = []
      @links.each do |link|
        @client_names.push(@clients.find(link.client_id).name)
        @created_times.push(local_time(link.created_at))
        if link.user_id
          @user_names.push(@users.find(link.user_id).first_name)
        end
      end
      respond_to do |format|
        format.html
        format.js
        format.json
      end
      return @links.to_json
    end
  end

  def add_user_info_to_link(link)
    if current_user
      @user_info = current_user.id
      link.user_id = @user_info
      link.save
      @user_info = @user_info.to_s
    else
      @user_info = session.id
      session[:user_info] = session.id
      link.created_by = @user_info
      link.save
    end
  end
end
