class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  private

  def not_authorized
    flash[:danger] = 'You are not allowed to do that.'
    redirect_to root_url
  end
end
