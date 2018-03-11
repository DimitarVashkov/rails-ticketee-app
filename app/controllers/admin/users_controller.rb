class Admin::UsersController < Admin::ApplicationController
  def index
    @users = User.order(:email)
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User has been created.'
      redirect_to admin_users_url
    else
      flash.now[:danger] = 'User has not been created.'
      render 'new'
    end
  end

  def user_params
    params.require(:user).permit(:email, :password, :admin)
  end
end
