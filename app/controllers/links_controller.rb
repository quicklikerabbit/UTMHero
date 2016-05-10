class LinksController < ApplicationController
  include ApplicationHelper
  respond_to :html, :js

  def index
    require_logged_in_user
    if current_user
      @client_links = ClientUser.where(user_id: current_user.id).pluck(:client_id)
      @links = Link.where(client_id: @client_links).order(created_at: :desc)

      @link = Link.new
      @clients = Client.all
      @users = User.all
      @last_link = Link.last

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
    if current_user == nil
      session[:start_time] ||= Time.now
    end

    if Client.find_by(name: link_params[:client_id]) == nil
      @client = Client.new(name: link_params[:client_id])
      @client.save
      @link.client_id = @client.id
      @link.save
      if current_user
        ClientUser.create(
          client_id: @client.id,
          user_id: current_user.id
          )
        @link.user_id = current_user.id
        @link.save
      else

      end
    else
      @link.client_id = Client.find_by(name: link_params[:client_id]).id
      @link.save
      if current_user
        @link.user_id = current_user.id
      else
        @link.user_id = nil
      end
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
