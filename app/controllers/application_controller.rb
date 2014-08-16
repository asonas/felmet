class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :auth

  def auth
    secrets = Rails.application.secrets
    return unless secrets.basic_auth_user && secrets.basic_auth_pass
    unless Rails.env.development?
      authenticate_or_request_with_http_basic do |user, pass|
        user == secrets.basic_auth_user && pass == secrets.basic_auth_pass
      end
    end
  end

end
