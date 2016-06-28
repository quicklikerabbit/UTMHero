class LinksController < ApplicationController

  include ApplicationHelper
  respond_to :html, :js

  def index
    require_logged_in_user
    @client_user = ClientUser.new
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
    end
  end

  def show
  end

  def new
    @link = Link.new
  end

  def edit
  end

  def create
    @link = Link.create(link_params)
    if current_user
      @user_info = current_user.id
      @link.user_id = @user_info
      @link.save
      @user_info = @user_info.to_s
    else
      @user_info = session.id
      session[:user_info] = session.id
      @link.created_by = @user_info
      @link.save
    end

    @clients = Client.where("name LIKE ? AND created_by = ?", link_params[:client_id], @user_info)

    if @clients == []
      @client = Client.create(
        name: link_params[:client_id],
        created_by: @user_info
        )
      @link.client_id = @client.id
      @link.save
      if current_user
        ClientUser.create(
          client_id: @client.id,
          user_id: current_user.id
          )
        @client.created_by = current_user.id
        @client.save
        @link.user_id = current_user.id
        @link.save
      else
        @client.created_by = @user_info
        @client.save
      end
    else
      @link.client_id = @clients.find_by(name: link_params[:client_id]).id
      @link.save
    end

    respond_to do |format|
      format.html
      format.js
      format.json
    end

  end

  def destroy
  end

  protected

  def link_params
    params.require(:link).permit(
      :link_reference, :communication_id, :campaign_medium, :campaign_source, :campaign_name, :utm_content, :short_link, :website_url, :client_id
    )
  end
end
