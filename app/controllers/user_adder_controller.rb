class UserAdderController < ApplicationController

  include ApplicationHelper

  def new
    @add_user = UserAdder.new
  end

  def create
    require_logged_in_user

    @add_user = UserAdder.create(user_adder_params)

    @user_id = User.find_by(email: @add_user.user_email)
    if @user_id == nil
      flash[:error] = "Could not find user, have they signed up yet?"
      redirect_to links_path
    else
      @user_id = @user_id.id
    end

    @client = Client.where(name: @add_user.client)
    if @client == []
      flash[:error] = "Could not find Client"
      redirect_to links_path
    else
      client_user = add_client_user(@client, @user_id)
      if client_user == nil
        flash[:error] = "Could not find Client in your links"
        redirect_to links_path
      else
        flash[:notice] = "Links successfully shared!"
      end
    end
  end

  def destroy
  end

  protected

  def user_adder_params
    params.require(:user_adder).permit(
      :client, :user_email
      )
  end

end
