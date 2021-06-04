# frozen_string_literal: true

class CardBundle < ApplicationRecord
  belongs_to :parent_bundle, class_name: "CardBundle"
  belongs_to :current_assignee, class_name: "User"
  belongs_to :loaded_by, class_name: "User"

  enum status: {
    new: 1,
    loaded: 5,
    assigned: 10
  }
end
