module ClientsHelper
  def create_client(link)
    @clients = Client.where("name LIKE ? AND created_by = ?", link_params[:client_id], @user_info)

    if @clients == []
      @client = Client.create(
        name: link_params[:client_id],
        created_by: @user_info
        )
      link.client_id = @client.id
      link.save
      if current_user
        ClientUser.create(
          client_id: @client.id,
          user_id: current_user.id
          )
        @client.created_by = current_user.id
        @client.save
        link.user_id = current_user.id
        link.save
      else
        @client.created_by = @user_info
        @client.save
      end
    else
      link.client_id = @clients.find_by(name: link_params[:client_id]).id
      link.save
    end
  end
end
