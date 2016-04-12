class LinksController < ApplicationController
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
    byebug
    @link = Link.new(link_params)
    @link.client_id = Client.find_by(name: link_params[:client_id]).id
    @link.save
    if @link.save
      redirect_to root_path, notice: "Link Created!"
    else
      render :form, notice: "Link Not created"
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
