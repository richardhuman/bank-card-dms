# frozen_string_literal: true

module CurrentUser
  extend ActiveSupport::Concern

  SESSION_USER_KEY = :user_id

  included do
    before_action :require_user
  end

  private
    def current_user
      return @current_user if defined?(@current_user)
      return nil if session[SESSION_USER_KEY].nil?

      user  = User.find_by(id: session[SESSION_USER_KEY])

      return nil if user.nil?
      @current_user = user
    end

    def require_user
      unless current_user
        store_location
        redirect_to url_for({ controller: :user_logins, action: :new })
      end
    end

    def store_location
      session[:return_to] = request.fullpath
    end

end
