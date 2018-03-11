class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: %i[show edit update destroy archive]
  before_action :set_projects, only: %i[new create edit update]
  def index
    @users = User.excluding_archived.order(:email)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    build_roles_for(@user)
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

    User.transaction do
      @user.roles.clear
      build_roles_for(@user)
      role_data = params.fetch(:roles, [])
      role_data.each do |project_id, role_name|
        if role_name.present?
          @user.roles.build(project_id: project_id, role:role_name)
        end
      end
    end

    if @user.update(user_params)
      flash[:success] = 'User has been updated.'
      redirect_to admin_users_url
    else
      flash[:danger] = 'User has not been updated.'
      render 'edit'
      raise ActiveRecord::Rollback
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

  private
  def set_projects
    @projects = Project.order(:name)
  end

  def build_roles_for(user)
    role_data = params.fetch(:roles,[])
    role_data.each do |project_id, role_name|
      if role_name.present?
        user.roles.build(project_id: project_id, role: role_name)
      end
    end
  end
end
