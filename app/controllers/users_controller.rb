class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id # auto log in
      if session[:start_time]
        @client_users = ClientUser.all
        @new_links = Link.where("created_at > ?", session[:start_time])
        @new_links.each do |new_link|
          byebug
          new_link.user_id = @user.id
          new_link.save
          ClientUser.create(
            client_id: new_link.client_id,
            user_id: new_link.user_id
            )
        end
      end
      redirect_to links_path, notice: "Hey there, #{@user.first_name}!"
    else
      render :new
    end
  end

  def edit
  end

  protected

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
