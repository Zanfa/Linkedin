class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :reset_invite_key

  def get_current_user
    User.find(session[:user])
  end

  def reset_invite_key
    session[:invite_key] = nil
  end
end
