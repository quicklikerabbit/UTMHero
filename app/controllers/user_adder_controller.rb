class UserAdderController < ApplicationController

  include ApplicationHelper

  def new
    @add_user = UserAdder.new
  end

  def create
    require_logged_in_user
    @add_user = UserAdder.create(user_adder_params)
    add_client_user(@add_user.client, @add_user.user_email)
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
