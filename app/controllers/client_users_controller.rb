class ClientUsersController < ApplicationController
  def new
    @client_user = ClientUser.new
  end

  def create
    @client_user = ClientUser.new
  end

  def destroy
  end
end
