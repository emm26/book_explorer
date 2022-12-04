class ApplicationController < ActionController::Base
  before_action :redirect_unless_signed_in

  def redirect_unless_signed_in
    unless user_signed_in? || [new_user_registration_path, new_user_session_path, new_user_password_path, user_password_path].include?(request.fullpath)
      redirect_to new_user_session_path
    end
  end
end
