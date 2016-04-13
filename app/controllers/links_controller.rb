class LinksController < ApplicationController
  respond_to :html, :js
  
  def index
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
      @utm_link = "#{@link.website_url}/?utm_source=#{@link.campaign_source}&utm_medium=#{@link.campaign_medium}&utm_term=#{@link.communication_id}&utm_content=#{@link.utm_content}&utm_campaign=#{@link.campaign_name}"
    else
      @link.client_id = Client.find_by(name: link_params[:client_id]).id
      @link.save
      @utm_link = "#{@link.website_url}/?utm_source=#{@link.campaign_source}&utm_medium=#{@link.campaign_medium}&utm_term=#{@link.communication_id}&utm_content=#{@link.utm_content}&utm_campaign=#{@link.campaign_name}"
    end
    respond_to do |format|
      format.html { redirect_to @utm_link, notice: 'Link was successfully created.' }
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
