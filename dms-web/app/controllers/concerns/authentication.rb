# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  SESSION_USER_KEY = :user_id

  included do
    before_action :authenticate
  end

  private
    def authenticate
      authenticated_user = User.find_by(id: cookies.encrypted[SESSION_USER_KEY])
      if authenticated_user
        CurrentRequest.user_id = authenticated_user.id
      else
        store_unauthenticated_location
        redirect_to new_user_session_url
      end
    end

    def create_session(user)
      # CurrentRequest.user = user
      cookies.encrypted[SESSION_USER_KEY] = user.id
    end

    def delete_session
      cookies.encrypted[SESSION_USER_KEY] = nil
      CurrentRequest.user_id = nil
    end

    def current_user
      User.find_by(id: CurrentRequest.user_id)
    end

    def store_unauthenticated_location
      cookies.encrypted[:return_to] = request.fullpath
    end

    def get_unauthenticated_location
      cookies.encrypted[:return_to]
    end

    def clear_unauthenticated_location
      cookies.encrypted[:return_to] = nil
    end
end
