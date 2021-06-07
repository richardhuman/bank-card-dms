# frozen_string_literal: true

class CardBundle < ApplicationRecord
  belongs_to :parent_bundle, class_name: "CardBundle", optional: true
  belongs_to :current_assignee, class_name: "User", optional: true
  belongs_to :loaded_by, class_name: "User", optional: true
  belongs_to :deleted_by, class_name: "User", optional: true

  validates :bundle_number, uniqueness: { case_sensitive: false }, presence: true

  scope :active, -> () { (where(deleted_at: nil)) }

  before_commit :mark_bundle_as_loaded

  enum status: {
    empty: 1,
    prepared: 5,
    assigned: 10
  }

  def handle_delete!
    self.deleted_at = Time.new
    self.deleted_by = CurrentRequest.user
    save!
  end

  private
    def mark_bundle_as_loaded
      self.loaded_by = current_user
      self.prepared!
    end
end
