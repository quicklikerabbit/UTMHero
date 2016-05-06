class LinksController < ApplicationController
  include ApplicationHelper
  respond_to :html, :js

  def index
    require_logged_in_user

    # @client_links = ClientUser.where(user_id: current_user.id).pluck(:client_id)
    # @links = Link.where(id: @client_links).order(created_at: :desc)

    @links = Link.all
    @clients = Client.all
    @users = User.all
    @client_names = []
    @user_names = []
    @links.each do |link|
      @client_names.push(@clients.find(link.client_id).name)
      if link.user_id
        @user_names.push(@users.find(link.user_id).first_name)
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
      end
    else
      @link.client_id = Client.find_by(name: link_params[:client_id]).id
      @link.save
    end
    respond_to do |format|
      format.html { redirect_to @utm_link }
      format.js   {}
      format.json { render json: @utm_link, status: :created, location: @utm_link }
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
