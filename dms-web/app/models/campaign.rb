# frozen_string_literal: true

class Campaign < ApplicationRecord
  include CurrentUser

  belongs_to :created_by, class_name: "User"
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 2000 }

  after_initialize :track_create_user

  scope :chronologically, -> () { order(created_at: :asc) }

  private
    def track_create_user
      self.created_by = current_user
    end
end
