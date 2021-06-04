# frozen_string_literal: true

class CardBundle < ApplicationRecord
  belongs_to :parent_bundle, class_name: "CardBundle", optional: true
  belongs_to :current_assignee, class_name: "User", optional: true
  belongs_to :loaded_by, class_name: "User", optional: true

  validates :bundle_number, uniqueness: { case_sensitive: false }, presence: true

  enum status: {
    empty: 1,
    prepared: 5,
    assigned: 10
  }
end
