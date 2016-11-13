class LinksController < ApplicationController

  include ApplicationHelper
  include LinksHelper
  include ClientsHelper
  respond_to :html, :js

  def index
    require_logged_in_user
    @add_user = UserAdder.new
    links_table_content
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
    add_user_info_to_link(@link)
    create_client(@link)

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
