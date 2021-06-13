# frozen_string_literal: true

module BackOffice
  class BaseController < ApplicationController
    before_action :ensure_back_office_access

    def sub_layout
      "back_office"
    end

    private
      def ensure_back_office_access
        unless current_user&.back_office_role?
          redirect_to new_user_session_path, alert: t("user_sessions.access.errors.denied"), status: :forbidden
        end
      end
  end
end
