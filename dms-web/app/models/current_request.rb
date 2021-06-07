# frozen_string_literal: true

class CurrentRequest < ActiveSupport::CurrentAttributes
  attribute :user_id

  def user_id=(user_id)
    super
  end
end
