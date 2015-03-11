class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def current_user
      warden.user
    end
    helper_method :current_user

    def is_logged_in?
      current_user.present?
    end
    helper_method :is_logged_in?

    def warden
      env['warden']
    end
end
