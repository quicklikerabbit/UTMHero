class UserAdderController < ApplicationController

  include ApplicationHelper

  def new
    @add_user = UserAdder.new
  end

  def create
    require_logged_in_user

    @add_user = UserAdder.create(user_adder_params)

    @user_id = User.find_by(email: add_user_email).id
    if @user_id == nil
      flash[:error] = "Could not find user, have they signed up yet?"
      redirect_to links_path
    end

    @client = Client.where(name: client)
    if @client == []
      flash[:error] = "Could not find Client"
      redirect_to links_path
    else
      add_client_user(@add_user.client, @add_user.user_email, @client)
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
