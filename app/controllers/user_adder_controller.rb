class UserAdderController < ApplicationController
  def new
    @add_user = UserAdder.new
  end

  def create
    @add_user = UserAdder.new
  end

  def destroy
  end
end
