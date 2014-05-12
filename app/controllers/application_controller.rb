class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def require_login
    render text: :not_allowed_to_do_that.l, status: :forbidden
  end
end
