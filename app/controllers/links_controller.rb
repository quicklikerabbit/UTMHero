class LinksController < ApplicationController
  include ApplicationHelper
  respond_to :html, :js

  def index
    require_logged_in_user
    @links = Link.all    
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
