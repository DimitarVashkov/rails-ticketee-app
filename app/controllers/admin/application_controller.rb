class Admin::ApplicationController < ApplicationController
  before_action :authorize_admin!
  def index
  end

  private
  def authorize_admin!
    authenticate_user!
    unless current_user.admin?
      flash[:danger] = 'You must be an admin to do that.'
      redirect_to root_url
    end
  end
end
