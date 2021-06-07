# frozen_string_literal: true

module CurrentUser
  extend ActiveSupport::Concern

  def current_user
    User.find_by(id: CurrentRequest.user_id)
  end
end
