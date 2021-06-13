# frozen_string_literal: true

class BundleTransaction < ApplicationRecord
  belongs_to :bundle
  belongs_to :logged_by, class_name: "User"
  belongs_to :executed_by, class_name: "User"
  belongs_to :transferee, class_name: "User", optional: true

  scope :chronologically, ->() { order(created_at: :asc) }
  scope :reverse_chronologically, ->() { order(created_at: :desc) }
  scope :recent_transactions, -> () { reverse_chronologically.includes(:logged_by, :executed_by, :transferee, bundle: :campaign).limit(10) }

  after_create_commit -> { broadcast_replace_later_to "broadcast_dashboard_bundle_transactions",
                                                      target: "dashboard_bundle_transactions",
                                                      partial: "back_office/dashboard/recent_transactions" }

  enum transaction_type: {
    loaded: 1,
    released: 5,
    transfer: 10,
    sale: 15,
    return: 20,
    completed: 25
  }, _suffix: "txn"
end
