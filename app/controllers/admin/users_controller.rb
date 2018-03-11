class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: %i[show edit update destroy archive]
  def index
    @users = User.excluding_archived.order(:email)
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

  def show; end

  def edit; end

  def update
    # passwords are stored as digests
    # and we can't store a blank password
    params[:user].delete(:password) if params[:user][:password].blank?

    if @user.update(user_params)
      flash[:success] = 'User has been updated.'
      redirect_to admin_users_url
    else
      flash[:danger] = 'User has not been updated.'
      render 'edit'
    end
  end

  def archive
    if @user == current_user
      flash[:danger] = 'You cannot archive yourself!'
    else
      @user.archive
      flash[:notice] = 'User has been archived.'
    end
    redirect_to admin_users_url
  end



  def user_params
    params.require(:user).permit(:email, :password, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
